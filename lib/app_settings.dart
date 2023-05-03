import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSettings extends ChangeNotifier {
  static const String keyApiUrl = 'ApiURL';
  static const String keyOauthAuthorizationUrl = "OauthAuthUrl";
  static const String keyOauthTokenUrl = "OauthTokenUrl";
  static const String keyOauthRedirectUri='OuthRedirectUri';
  static const String keyOauthClientId = 'OauthClientId';
  static const String keyOauthClientSecret = 'OauthClientSecret';
  static const String keyUserId = 'UserId';
  static const String keyPassword = 'Password';
  static const String keyLastActivityId = 'LastActivityId';
  static const String keyPrinter = 'Printer';

  static AppSettings? _instance;

  late Future<SharedPreferences> _prefs;
  late SharedPreferences _storage;
  late FlutterSecureStorage _secureStorage;

  // local storage of secret values (to overcome async complexity)
  late String _oauthClientSecret;
  late String _password;
  

  String get apiUrl {
    return _getString(keyApiUrl);
  }

  set apiUrl(String value) {
    _setString(keyApiUrl, value);
    notifyListeners();
  }

  String get oauthAuthorizationUrl {
    return _getString(keyOauthAuthorizationUrl);
  }

  set oauthAuthorizationUrl(String value) {
    _setString(keyOauthAuthorizationUrl, value);
    notifyListeners();
  }

  String get oauthTokenUrl {
    return _getString(keyOauthTokenUrl);
  }

  set oauthTokenUrl(String value) {
    _setString(keyOauthTokenUrl, value);
    notifyListeners();
  }

  String get oauthRedirectUri {
    return _getString(keyOauthRedirectUri);
  }

  set oauthRedirectUri(String value) {
    _setString(keyOauthRedirectUri, value);
    notifyListeners();
  }

  String get oauthClientId {
    return _getString(keyOauthClientId);
  }

  set oauthClientId(String value) {
    _setString(keyOauthClientId, value);
    notifyListeners();
  }

  String get oauthClientSecret {
    return _oauthClientSecret;
  }

  set oauthClientSecret(String value) {
    _oauthClientSecret = value;
    _setSecureString(keyOauthClientSecret, value);
    notifyListeners();
  }

  String get userId {
    return _getString(keyUserId);
  }

  set userId(String value) {
    _setString(keyUserId, value);
    notifyListeners();
  }

  String get password {
    return _password;
  }

  set password(String value) {
    _password = value;
    _setSecureString(keyPassword, value);
    notifyListeners();
  }

  int get lastActivityId {
    return _getInt(keyLastActivityId);
  }

  set lastActivityId(int value) {
    _setInt(keyLastActivityId, value);
  }
    String get printer {
    return _getString(keyPrinter);
  }

  set printer(String value) {
    _setString(keyPrinter, value);
    notifyListeners();
  }

  /// Private constructor
  AppSettings._create() {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = SharedPreferences.getInstance();
    _oauthClientSecret = '';
    _password = '';
  }

  /// Public factory
  static Future<AppSettings> create() async {
    if (_instance == null) {
      // Call the private constructor
      _instance = AppSettings._create();
      // Do initialization that requires async
      WidgetsFlutterBinding.ensureInitialized();
      await _instance!._load();
    }
    // Return the fully initialized object
    return _instance!;
  }

  static AppSettings get instance {
    return _instance!;
  }

  Future<void> _load() async {
    _storage = await _prefs;
    _secureStorage = FlutterSecureStorage(
      // iOptions: const IOSOptions(),
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      // lOptions: const LinuxOptions(),
      // webOptions: const WebOptions(),
      // mOptions: const MacOsOptions(),
      // wOptions: const WindowsOptions(),
    );
    await _loadSecureStrings();
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

  Future _loadSecureStrings() async {
    _oauthClientSecret = await _getSecureString(keyOauthClientSecret);
    _password = await _getSecureString(keyPassword);
  }
}
