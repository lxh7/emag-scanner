import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/app_settings.dart';
import '/data/local_data_store.dart';
import '/data/backend_data_store.dart';
import '/data/dequeue_scan_info.dart';
import '/enums/api_connection_state.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/models/scan_info.dart';
import '/models/access_check_result.dart';
import '/util/internet_connection_listener.dart';

class DataManager extends ChangeNotifier {
  ApiConnectionState _apiConnectionState = ApiConnectionState.none;
  int _apiCheckInterval =
      1; // polling interval (seconds) trying to reach Backend. Will be increaed with every try (max 10 seconds).
  Timer? _apiCheckTimer;

  late InternetConnectionListener _internetConnectionListener;
  late AppSettings _appSettings;
  late BackendDataStore _backend;
  late LocalDataStore _local;
  late List<Activity> _storedActivities;
  Activity? _selectedActivity;

  DataManager(BuildContext context) {
    _backend = context.read<BackendDataStore>();
    _local = context.read<LocalDataStore>();

    _internetConnectionListener = context.read<InternetConnectionListener>();
    _internetConnectionListener.addListener(_internetConnectionChanged);

    _appSettings = context.read<AppSettings>();
    _appSettings.addListener(_appSettingsChanged);
    _appSettingsChanged(); // call after _backend has been initialized

    _storedActivities = _local.getActivities();
    if (_storedActivities.isNotEmpty) {
      _selectedActivity = _storedActivities.first;
    }

    if (_internetConnectionListener.connected) {
      apiConnectionState = ApiConnectionState.backendCheck;
    }
  }

  void _internetConnectionChanged() {
    if (_internetConnectionListener.connected) {
      apiConnectionState = ApiConnectionState.backendCheck;
    } else {
      apiConnectionState = ApiConnectionState.none;
    }
  }

  void _appSettingsChanged() {
    _backend.configure(_appSettings);
  }

  ApiConnectionState get apiConnectionState {
    return _apiConnectionState;
  }

  set apiConnectionState(ApiConnectionState value) {
    if (_apiConnectionState != value) {
      _apiConnectionState = value;
      switch (value) {
        case ApiConnectionState.none:
          // nothing to do
          break;
        case ApiConnectionState.backendCheck:
          // start or continue checking API connectivity
          _apiCheckInterval = 0;
          _checkApi();
          break;
        case ApiConnectionState.backendFail:
          // it stops here....
          break;
        case ApiConnectionState.authCheck:
          // start or continue checking API connectivity
          _apiCheckInterval = 0;
          _checkApi();
          break;
        case ApiConnectionState.authFail:
          // it stops here....
          break;
        case ApiConnectionState.full:
          // start Scan Info dequeue process
          DequeueScanInfo(_local, _backend).run();
          break;
      }
      notifyListeners();
    }
  }

  void _checkApi() {
    if (_apiCheckTimer != null) {
      _apiCheckTimer!.cancel();
      _apiCheckTimer = null;
    }
    try {
      switch (apiConnectionState) {
        case ApiConnectionState.none:
          // cannot check connection to the API as we don't have an internet connection at all
          break;
        case ApiConnectionState.backendCheck:
          _backend.canReachBackendAsync().then((canReach) {
            if (canReach) {
              apiConnectionState = ApiConnectionState.authCheck;
              _checkApi();
            } else {
              _retryCheckApi();
            }
          });
          break;
        case ApiConnectionState.authCheck:
          _backend.ensureLoggedInAsync().then((loggedIn) {
            if (!loggedIn) {
              apiConnectionState = ApiConnectionState.authFail;
            } else {
              apiConnectionState = ApiConnectionState.full;
            }
          });
          break;
        case ApiConnectionState.backendFail:
        case ApiConnectionState.authFail:
        case ApiConnectionState.full:
          // not much more we can do
          break;
      }
    } catch (e) {
      _retryCheckApi();
    }
  }

  _retryCheckApi() {
    // keep trying while we have an internet connection but not fully connected
    if (apiConnectionState == ApiConnectionState.backendCheck) {
      if (_apiCheckInterval < 10) {
        _apiCheckInterval++;
        _apiCheckTimer = Timer(Duration(seconds: _apiCheckInterval), _checkApi);
      } else {
        apiConnectionState = ApiConnectionState.backendFail;
      }
    }
  }

  bool get isConnected {
    return _apiConnectionState == ApiConnectionState.full;
  }

  set selectedActivity(Activity? value) {
    _selectedActivity = value;
    notifyListeners();
  }

  Activity? get selectedActivity {
    return _selectedActivity;
  }

  Future<List<ActivityCategory>> getCategories() async {
    List<ActivityCategory>? result;
    if (isConnected) {
      result = await _backend.getCategoriesAsync();
      if (result.isNotEmpty) {
        _local.storeCategories(result);
      }
    } else {
      result = _local.getCategories();
    }
    return result;
  }

  Future<List<Activity>> getActivities(ActivityCategory category) async {
    List<Activity>? result;
    if (isConnected) {
      result = await _backend.getActivitiesAsync(category.id);
    }
    if (result != null) {
      return result;
    }
    return List<Activity>.empty();
  }

  Future<Activity?> refreshActivityAsync(Activity activity) async {
    var freshActivity = await _backend.getActivityAsync(activity.id);
    if (freshActivity == null) {
      return null;
    }
    _local.upsertActivity(freshActivity);
    _replaceStoredActivity(activity, freshActivity);
    return freshActivity;
  }

//#region StoredActivities

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Activity> get storedActivities =>
      UnmodifiableListView(_storedActivities);

  /// Adds [item] to cart. This and [remove] are the only ways to modify the
  /// cart from the outside.
  void addStoredActivity(Activity activity) {
    _local.upsertActivity(activity);
    _storedActivities.add(activity);
    notifyListeners();
  }

  void removeStoredActivity(Activity activity) {
    if (_selectedActivity?.id == activity.id) {
      _selectedActivity = null;
    }
    _local.deleteActivity(activity);
    _storedActivities.remove(activity);
    notifyListeners();
  }

  void _replaceStoredActivity(Activity original, Activity replaceBy) {
    _local.upsertActivity(replaceBy);
    if (_storedActivities.contains(original)) {
      _storedActivities.remove(original);
      _storedActivities.add(replaceBy);
      notifyListeners();
    }
  }
//#endregion

  Future<AccessCheckResult> checkAccess(ScanInfo info) async {
    AccessCheckResult result;
    if (isConnected) {
      result = await _backend.queryAccessAsync(
        info.activityId,
        info.personKey,
        info.scanTime,
      );
      _local.checkAccess(info);
    } else {
      result = _local.queryAccess(info);
    }
    return result;
  }

  Future<Activity?> getActivity(int activityId) async {
    if (isConnected) {
      return await _backend.getActivityAsync(activityId);
    } else {
      return _local.getActivity(activityId);
    }
  }
}
