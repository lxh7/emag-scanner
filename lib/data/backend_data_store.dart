import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:scan/backend_api/lib/api.dart';

import '/app_settings.dart';
import '/enums/scan_result.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/models/access_check_result.dart';
import '/util/dto_helper.dart';

class BackendDataStore {
  // OAuth stuff
  static OAuth2Client? _oauthClient;
  static AccessTokenResponse? _oauthToken;
  // OpenApi stuff
  static OAuth? _oauthAuthentication;

  static BackendDataStore? _singleton;
  factory BackendDataStore() {
    _singleton ??= BackendDataStore._privateConstructor();
    return _singleton!;
  }

  BackendDataStore._privateConstructor() {
    AppSettings.instance.addListener(_settingsChanged);
  }

  Future canReach() async {
    ensureApiConfigured();
    HealthApi().health();
  }

  Future<List<ActivityCategory>> getCategories() async {
    if (await _ensureLoggedIn()) {
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

  Future<List<Activity>> getActivities(int? categoryId) async {
    if (await _ensureLoggedIn()) {
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

  Future<Activity?> getActivity(int activityId) async {
    if (await _ensureLoggedIn()) {
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
          return activity;
        }
      } catch (e) {
        print('Exception when calling EventApi->listEvents: $e\n');
      }
    }
    return null;
  }

  Future<AccessCheckResult> queryAccess(int activityId, String personKey, DateTime scanTime) async {
    if (await _ensureLoggedIn()) {
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

  void _settingsChanged() {
    // some settings have changed, make sure we re-authenticate. Clear all authentication objects
    defaultApiClient = ApiClient();
    _oauthClient = null;
    _oauthToken = null;
    _oauthAuthentication = null;
  }

  Future<bool> _ensureLoggedIn() async {
    // do we have a token, and is it still valid?
    if (_oauthToken?.isExpired() == false) {
      return true;
    }

    var settings = AppSettings.instance;
    _oauthClient ??= OAuth2Client(
        authorizeUrl: settings.oauthAuthorizationUrl,
        tokenUrl: settings.oauthTokenUrl,
        redirectUri: settings.oauthRedirectUri,
        customUriScheme: '');
    // if we already have a token (with refreshToken), check if it is expired and in that case refresh it...
    if (_oauthToken?.refreshToken != null && !_oauthToken!.isExpired()) {
      _oauthToken = await _oauthClient!.refreshToken(
        _oauthToken!.refreshToken!,
        clientId: settings.oauthClientId,
      );
    } else {
      //Request a token using the Authorization Code flow...
      _oauthToken = await _oauthClient!.getTokenWithClientCredentialsFlow(
        clientId: settings.oauthClientId,
        clientSecret: settings.oauthClientSecret,
        // scopes: ['scope1'],
      );
    }

    // Configure OpenApi access token for authorization: OAuth2, or update  the access token
    var accessToken = _oauthToken!.accessToken ?? '';
    if (accessToken == '') {
      return false;
    }
    if (_oauthAuthentication == null) {
      _oauthAuthentication = OAuth(accessToken: accessToken);
    } else {
      _oauthAuthentication!.accessToken = accessToken;
    }

    ensureApiConfigured();
    return true;
  }

  // public function, so that checking Health can be done elsewhere
  static void ensureApiConfigured() {
    // did we ever initiate our defaultApiClient?
    if (defaultApiClient.basePath == '' ||
        defaultApiClient.basePath == 'http://localhost') {
      defaultApiClient = ApiClient(
        basePath: AppSettings.instance.apiUrl,
        authentication: _oauthAuthentication,
      );
    }
  }
}
