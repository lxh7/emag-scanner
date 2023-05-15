import 'package:emagscan/apis/backend/lib/api.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';

import '/app_settings.dart';
import '/enums/scan_result.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/models/access_check_result.dart';
import '/util/dto_helper.dart';

class BackendDataStore {
  static OAuth2Client? _oauthClient;
  static AccessTokenResponse? _oauthAccessTokenResponse;
  static OAuth? _oauth;

  late AppSettings _appSettings;

  static final BackendDataStore _instance = BackendDataStore._initialize();

  factory BackendDataStore() {
    return _instance;
  }

  BackendDataStore._initialize() {
    // nothing, at the moment
  }

  void configure(AppSettings settings) {
    _appSettings = settings;
    // reset all OAUTH stuff to ensure fresh login
    defaultApiClient = ApiClient();
    _oauthClient = null;
    _oauthAccessTokenResponse = null;
    _oauth = null;
  }

  Future<bool> canReachBackendAsync() async {
    ensureApiConfigured();
    try {
      await HealthApi().health();
      return true;
    } catch (e) {
      // cannot reach
      return false;
    }
  }

  Future<String?> getAccessToken() async {
    if (await canReachBackendAsync()) {
      await ensureLoggedInAsync();
      return _oauthAccessTokenResponse?.accessToken;
    } else {
      return null;
    }
  }

  Future<List<ActivityCategory>> getCategoriesAsync() async {
    if (await ensureLoggedInAsync()) {
      var api = CategoryApi();

      try {
        var list = await api.listCategories();
        if (list != null) {
          return list
              .map((x) => ActivityCategory(
                    x.id!,
                    x.name!,
                  ))
              .toList();
        }
      } catch (e) {
        print('Exception when calling CategoryApi->listCategories: $e\n');
      }
    }
    return List<ActivityCategory>.empty();
  }

  Future<List<Activity>> getActivitiesAsync(int? categoryId) async {
    if (await ensureLoggedInAsync()) {
      var api = EventApi();

      try {
        List<EventDTO>? list;
        if (categoryId == null) {
          list = await api.listEvents();
        } else {
          list = await api.listEvents(categoryId: categoryId);
        }

        if (list != null) {
          return list.map(DtoHelper.fromEventDTO).toList();
        }
      } catch (e) {
        print('Exception when calling EventApi->listEvents: $e\n');
      }
    }
    return List<Activity>.empty();
  }

  Future<Activity?> getActivityAsync(int activityId) async {
    if (await ensureLoggedInAsync()) {
      var api = EventApi();
      try {
        var eventDTO = await api.getEvent(activityId);
        if (eventDTO == null) {
          return null;
        }
        var activity = DtoHelper.fromEventDTO(eventDTO);
        var participants = await api.getParticipants(activityId);
        if (participants?.isNotEmpty == true) {
          activity.participants.clear();
          activity.participants.addAll(participants!
              .map((e) => ActivityParticipant(
                    e.participantId!,
                    scanTime: null,
                  ))
              .toList());
        }
        return activity;
      } catch (e) {
        print('Exception when calling EventApi->listEvents: $e\n');
      }
    }
    return null;
  }

  Future<AccessCheckResult> queryAccessAsync(
      int activityId, String personKey, DateTime scanTime) async {
    if (await ensureLoggedInAsync()) {
      var api = EventApi();
      var access = await api.patchParticipant(
        activityId,
        personKey,
        ScanTimeDTO(scanTime: scanTime.toIso8601String()),
      );
      if (access == null) {
        return AccessCheckResult(
            scanResult: ScanResult.deny, message: 'No data returned');
      }
      switch (access.grant) {
        case 'pass':
          return AccessCheckResult(scanResult: ScanResult.pass);
        case 'check':
          return AccessCheckResult(
              scanResult: ScanResult.check,
              prevScanTime: DtoHelper.convertDate(
                access.prevScanTime,
                DateTime(2000, 1, 1),
              ));
        case 'deny':
          return AccessCheckResult(scanResult: ScanResult.deny);
      }
    }
    return AccessCheckResult(
        scanResult: ScanResult.error, message: 'Not logged in');
  }

  Future<bool> ensureLoggedInAsync() async {
    // do we have a token, and is it still valid?
    if (_oauthAccessTokenResponse?.isValid() == true &&
        _oauthAccessTokenResponse?.refreshNeeded() == false) {
      return true;
    }

    // we need a (new) token
    _oauthClient ??= OAuth2Client(
        authorizeUrl: _appSettings.oauthAuthorizationUrl,
        tokenUrl: _appSettings.oauthTokenUrl,
        redirectUri: _appSettings.oauthRedirectUri,
        customUriScheme: '');
    // if we already have a token (with refreshToken), check if it is (nearly) expired
    // and in that case refresh it...
    if (_oauthAccessTokenResponse?.refreshToken != null &&
        !_oauthAccessTokenResponse!.refreshNeeded()) {
      _oauthAccessTokenResponse = await _oauthClient!.refreshToken(
        _oauthAccessTokenResponse!.refreshToken!,
        clientId: _appSettings.oauthClientId,
      );
    } else {
      //Request a token using the Authorization Code flow...
      _oauthAccessTokenResponse =
          await _oauthClient!.getTokenWithClientCredentialsFlow(
        clientId: _appSettings.oauthClientId,
        clientSecret: _appSettings.oauthClientSecret,
        // scopes: ['scope1'],
      );
    }

    // Configure OpenApi access token for authorization: OAuth2, or update  the access token
    var accessToken = _oauthAccessTokenResponse!.accessToken ?? '';
    if (accessToken == '') {
      return false;
    }
    _oauth = OAuth(accessToken: accessToken);

    // force refresh of apiClient
    defaultApiClient = ApiClient(
      basePath: _appSettings.apiUrl,
      authentication: _oauth,
    );
    return true;
  }

  // public function, so that checking Health can be done elsewhere
  void ensureApiConfigured() {
    // did we ever initiate our defaultApiClient?
    if (defaultApiClient.basePath == '' ||
        defaultApiClient.basePath == 'http://localhost') {
      defaultApiClient = ApiClient(
        basePath: _appSettings.apiUrl,
        authentication: _oauth,
      );
    }
  }
}
