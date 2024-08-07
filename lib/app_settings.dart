import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSettings extends ChangeNotifier {
  static const String keyApiUrl = 'ApiURL';
  // static const String keyOauthAuthorizationUrl = 'OauthAuthUrl';
  static const String keyOauthTokenUrl = 'OauthTokenUrl';
  // static const String keyOauthRedirectUri = 'OuthRedirectUri';
  static const String keyOauthClientId = 'OauthClientId';
  static const String keyOauthClientSecret = 'OauthClientSecret';
  static const String keyUserId = 'UserId';
  static const String keyPassword = 'Password';
  static const String keyGoodieCategories = 'GoodieCategories';
  static const String keySelectedActivityId = 'SelectedActivityId';

  late Future<SharedPreferences> _prefs;
  late SharedPreferences _storage;
  late FlutterSecureStorage _secureStorage;

  static final AppSettings _instance = AppSettings._constructor();

  factory AppSettings() {
    return _instance;
  }

  AppSettings._constructor() {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = SharedPreferences.getInstance();
  }

  get updSendPort => 9867;
  get updListenPort => 9868;

  Future initializeAsync() async {
    _storage = await _prefs;
    _secureStorage = const FlutterSecureStorage(
      // iOptions: IOSOptions(),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      // lOptions: LinuxOptions(),
      // webOptions: WebOptions(),
      // mOptions: MacOsOptions(),
      // wOptions: WindowsOptions(),
    );
  }

  String get apiUrl {
    return _getString(keyApiUrl);
  }

  set apiUrl(String value) {
    _setString(keyApiUrl, value);
    notifyListeners();
  }

  // String get oauthAuthorizationUrl {
  //   return _getString(keyOauthAuthorizationUrl);
  // }

  // set oauthAuthorizationUrl(String value) {
  //   _setString(keyOauthAuthorizationUrl, value);
  //   notifyListeners();
  // }

  String get oauthTokenUrl {
    return _getString(keyOauthTokenUrl);
  }

  set oauthTokenUrl(String value) {
    _setString(keyOauthTokenUrl, value);
    notifyListeners();
  }

  // String get oauthRedirectUri {
  //   return _getString(keyOauthRedirectUri);
  // }

  // set oauthRedirectUri(String value) {
  //   _setString(keyOauthRedirectUri, value);
  //   notifyListeners();
  // }

  String get oauthClientId {
    return _getString(keyOauthClientId);
  }

  set oauthClientId(String value) {
    _setString(keyOauthClientId, value);
    notifyListeners();
  }

  Future<String> getOauthClientSecret() async {
    return await _getSecureString(keyOauthClientSecret);
  }

  set oauthClientSecret(String value) {
    _setSecureString(keyOauthClientSecret, value);
    notifyListeners();
  }

  String get userId {
    return _getString(keyUserId);
  }

  set userId(String value) {
    value = value.trim();
    _setString(keyUserId, value);
    notifyListeners();
  }

  Future<String> getPassword() async {
    return await _getSecureString(keyPassword);
  }

  set password(String value) {
    value = value.trim();
    _setSecureString(keyPassword, value);
    notifyListeners();
  }

  int get selectedActivityId {
    var i = _getInt(keySelectedActivityId);
    return i;
  }

  set selectedActivityId(int activityId) {
    _setInt(keySelectedActivityId, activityId);
    // do not call notifyListeners(), this may result in flickering because DataManager re-intializes the API connection on changes
  }

  String _getString(String key) {
    var result = '';
    try {
      result = _storage.getString(key)!;
    } catch (e) {
      // error....
    }
    return result;
  }

  void _setString(String key, String value) {
    _storage.setString(key, value); // do not wait
  }

  int _getInt(String key) {
    int result = 0;
    try {
      result = _storage.getInt(key)!;
    } catch (e) {
      // error....
    }
    return result;
  }

  void _setInt(String key, int value) {
    _storage.setInt(key, value); // do not wait
  }

  Future _setSecureString(String key, String value) async {
    _secureStorage.write(key: key, value: value);
  }

  Future<String> _getSecureString(String key) async {
    var value = await _secureStorage.read(key: key);
    if (value == null) return '';
    return value;
  }

  int setValues(data) {
    int total = 0;
    total += _setValue(data, keyApiUrl, _setString);
    // total += _setValue(data, keyOauthAuthorizationUrl, _setString);
    total += _setValue(data, keyOauthTokenUrl, _setString);
    // total += _setValue(data, keyOauthRedirectUri, _setString);
    total += _setValue(data, keyOauthClientId, _setString);
    total += _setValue(data, keyOauthClientSecret, _setSecureString);
    total += _setValue(data, keyUserId, _setString);
    total += _setValue(data, keyPassword, _setSecureString);
    notifyListeners();
    return total;
  }

  int _setValue(dynamic data, String key,
      void Function(String key, String value) setterFunc) {
    try {
      final value = data[key.toLowerCase()] as String;
      if (value != '') {
        setterFunc(key, value);
        return 1;
      }
    } catch (e) {
      // key not supplied
    }
    return 0;
  }
}
