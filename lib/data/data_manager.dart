import 'dart:async';
import 'dart:collection';
import 'package:logger/logger.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/app_settings.dart';
import '/data/local_data_store.dart';
import '/data/backend_data_store.dart';
import '/data/dequeue_scan_info.dart';
import '/enums/api_connection_state.dart';
import '/logging/logging.dart';
import '/models/domain.dart';
import '/util/internet_connection_listener.dart';

class DataManager extends ChangeNotifier {
  ApiConnectionState _apiConnectionState = ApiConnectionState.none;
  late Logger _logger;
  int _apiCheckInterval =
      1; // polling interval (seconds) trying to reach Backend. Will be increaed with every try (max 10 seconds).
  Timer? _apiCheckTimer;
  late InternetConnectionListener _internetConnectionListener;
  late AppSettings _appSettings;
  late BackendDataStore _backend;
  late LocalDataStore _local;
  late List<Activity> _storedActivities;
  Activity? _selectedActivity;
  static DateTime? _categoriesFetchTime;

  oauth2.Client? _oauth2Client;

  bool _authenticationStarted = false;

  DataManager(BuildContext context) {
    _logger = getLogger(runtimeType.toString());
    _backend = context.read<BackendDataStore>();
    _local = context.read<LocalDataStore>();

    _internetConnectionListener = context.read<InternetConnectionListener>();
    _internetConnectionListener.addListener(_internetConnectionChanged);

    _appSettings = context.read<AppSettings>();
    _appSettings.addListener(_resetState);
    _resetState(); // call after _backend has been initialized

    _storedActivities = _local.getActivities();
    if (_storedActivities.isNotEmpty) {
      _selectedActivity = _storedActivities.first;
    }
  }

  void _internetConnectionChanged() {
    if (_internetConnectionListener.connected) {
      apiConnectionState = ApiConnectionState.authCheck;
    } else {
      apiConnectionState = ApiConnectionState.none;
    }
  }

  void _resetState() {
    _authenticationStarted = false;
    _oauth2Client = null;
    _backend.configure(_appSettings.apiUrl);
    if (_internetConnectionListener.connected) {
      apiConnectionState = ApiConnectionState.backendCheck;
    }
  }

  Future<String> getOauth2token() async {
    if (!_authenticationStarted) {
      _authenticationStarted = true;
      if (_oauth2Client == null) {
        try {
          var tokenUrl = _appSettings.oauthTokenUrl;
          var clientId = _appSettings.oauthClientId;
          var clientSecret = await _appSettings.getOauthClientSecret();
          if (Uri.tryParse(tokenUrl) == null ||
              clientId.isEmpty ||
              clientSecret.isEmpty ||
              Uri.tryParse(_appSettings.apiUrl) == null) {
            return '';
          }
          var username = _appSettings.userId;
          var password = await _appSettings.getPassword();
          if (username == '' || password == '') {
            _logger.d('Getting clientCredentialsGrant token on $tokenUrl');
            // either userId or password (or both) not set, can only authenticate at "client" level
            _oauth2Client = await oauth2.clientCredentialsGrant(
              Uri.parse(tokenUrl),
              clientId,
              clientSecret,
              // scopes: ...,
              basicAuth: false,
            );
          } else {
            _logger.d('Getting resourceOwnerPasswordGrant token on $tokenUrl');
            _oauth2Client = await oauth2.resourceOwnerPasswordGrant(
              // both userId or password are set, authenticate as a user (should give more priveleges)
              Uri.parse(tokenUrl),
              username,
              password,
              identifier: clientId,
              secret: clientSecret,
              // scopes: ['profile'],
              basicAuth: false,
            );
          }
          _logger.d('Got OAuth2 token');
        } on Exception catch (ex) {
          _logger.e('Exception getting OAuth2 token', ex);
        } catch (err) {
          _logger.e('Error getting OAuth2 token', err);
        }
      } else {
        // check if we need to refresh
        if (_oauth2Client!.credentials.isExpired &&
            !_oauth2Client!.credentials.canRefresh) {
          // we need a new token but cannot refresh. Re-create the OAuth2 Client
          _oauth2Client = null;
          _authenticationStarted = false;
          return await getOauth2token();
        }
      }
    }
    return _oauth2Client?.credentials.accessToken ?? '';
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
        case ApiConnectionState.authCheck:
        case ApiConnectionState.backendCheck:
          // start or continue checking API connectivity
          _apiCheckInterval = 0;
          _checkConnectivity();
          break;
        case ApiConnectionState.authFail:
        case ApiConnectionState.backendFail:
          // it stops here....
          break;
        case ApiConnectionState.full:
          // start Scan Info dequeue process
          DequeueScanInfo(_local, _backend, getOauth2token).run();
          break;
      }
      notifyListeners();
    }
  }

  Future<void> _checkConnectivity() async {
    if (_apiCheckTimer != null) {
      _apiCheckTimer!.cancel();
      _apiCheckTimer = null;
    }
    try {
      switch (apiConnectionState) {
        case ApiConnectionState.authCheck:
          var token = await getOauth2token();
          if (token == '') {
            apiConnectionState = ApiConnectionState.authFail;
          } else {
            apiConnectionState = ApiConnectionState.backendCheck;
          }
          break;
        case ApiConnectionState.backendCheck:
          var token = await getOauth2token();
          if (token == '') {
            // fall back to failed authentication
            apiConnectionState = ApiConnectionState.authFail;
          } else {
            var canReach = await _backend.canReachBackendAsync(token);
            if (canReach) {
              apiConnectionState = ApiConnectionState.full;
            } else {
              _retryCheckConnectivity();
            }
          }
          break;
        default: // not much more we can do
          break;
      }
    } catch (e) {
      _retryCheckConnectivity();
    }
  }

  _retryCheckConnectivity() {
    // keep trying while we have an internet connection but are not fully connected
    if (apiConnectionState == ApiConnectionState.backendCheck) {
      if (_apiCheckInterval < 10) {
        _apiCheckInterval++;
        _apiCheckTimer =
            Timer(Duration(seconds: _apiCheckInterval), _checkConnectivity);
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

  Future<List<Category>> getCategories() async {
    List<Category>? result;
    if (isConnected) {
      if (_categoriesFetchTime == null ||
          (DateTime.now().difference(_categoriesFetchTime!).inMinutes < 120)) {
        _categoriesFetchTime = DateTime.now();
        result = await _backend.getCategoriesAsync(await getOauth2token());
        if (result.isNotEmpty) {
          _local.storeCategories(result);
        }
      }
    }
    // if we shouldn't or couldn't fetch fresh list from API, get it local
    result ??= _local.getCategories();
    return result;
  }

  List<int> getGoodieCategories() {
    return _appSettings.goodieCategories;
  }

  void setGoodieCategories(List<int> values) {
    _appSettings.goodieCategories = values;
  }

  Future<List<Activity>> getActivities(Category category) async {
    List<Activity>? result;
    if (isConnected) {
      result = await _backend.getActivitiesAsync(
          await getOauth2token(), category.id);
    }
    if (result != null) {
      return result;
    }
    return List<Activity>.empty();
  }

  Future<Activity?> refreshActivityAsync(Activity activity) async {
    var freshActivity =
        await _backend.getActivityAsync(await getOauth2token(), activity.id);
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
      // backend is leading in determining access, use this result
      result = await _backend.queryAccessAsync(
        await getOauth2token(),
        info.activityId,
        info.personKey,
        info.scanTime,
      );
      // update local store
      _local.queryAccess(info);
    } else {
      // backend cannot be reached, rely on local store
      result = _local.queryAccess(info);
      // make sure scan info is synchronised to backend when we gain connectivity again.
      _local.queueScanInfo(info);
    }
    return result;
  }

  Future<Activity?> getActivity(int activityId) async {
    if (isConnected) {
      return await _backend.getActivityAsync(
          await getOauth2token(), activityId);
    } else {
      return _local.getActivity(activityId);
    }
  }

  Future<Person?> getPerson(String id) async {
    if (isConnected) {
      return await _backend.getPerson(await getOauth2token(), id);
    }
    return null;
  }
}
