import '/app_state.dart';
import '/enums/api_connection_state.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/models/scan_info.dart';
import '/models/access_check_result.dart';
import 'backend_data_store.dart';
import 'local_data_store.dart';

class DataManager {
  static bool _isConnected() {
    return AppState().connectionState == ApiConnectionState.full;
  }

  static Future<List<ActivityCategory>> getCategories() async {
    List<ActivityCategory>? result;
    if (_isConnected()) {
      result = await BackendDataStore().getCategories();
      if (result.isNotEmpty) {
        LocalDataStore().storeCategories(result);
      }
    } else {
      result = LocalDataStore().getCategories();
    }
    return result;
  }

  static Future<List<Activity>> getActivities(ActivityCategory category) async {
    List<Activity>? result;
    if (_isConnected()) {
      result = await BackendDataStore().getActivities(category.id);
    }
    if (result != null) {
      return result;
    }
    return List<Activity>.empty();
  }

  static List<Activity> storedActivities() {
    return LocalDataStore().getActivities();
  }

  static Future<Activity?> refreshActivity(Activity activity) async {
    var freshActivity = await BackendDataStore().getActivity(activity.id);
    if (freshActivity == null) {
      return null;
    }
    LocalDataStore().upsertActivity(freshActivity);
    return freshActivity;
  }

  static Future<void> addStoredActivity(Activity activity,
      {bool? refreshParticipants = true}) async {
    if (refreshParticipants == true) {
      var fresh = await BackendDataStore().getActivity(activity.id);
      if (fresh != null) {
        activity = fresh;
      }
    }
    LocalDataStore().upsertActivity(activity);
  }

  static void removeStoredActivity(Activity activity) {
    LocalDataStore().deleteActivity(activity);
  }

  static Future<AccessCheckResult> checkAccess(ScanInfo info) async {
    AccessCheckResult result;
    if (_isConnected()) {
      result = await BackendDataStore().queryAccess(
        info.activityId,
        info.personKey,
        info.scanTime,
      );
      LocalDataStore().checkAccess(info);
    } else {
      result = LocalDataStore().queryAccess(info);
    }
    return result;
  }

  static Future<Activity?> getActivity(int activityId) async {
    if (_isConnected()) {
      return await BackendDataStore().getActivity(activityId);
    } else {
      return LocalDataStore().getActivity(activityId);
    }
  }
}
