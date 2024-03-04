import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class KeyStorage {
  final tokenKey = "/token_key";
}

class Storage {
  static Storage? _instance;
  static bool hadInited = false;
  Storage._(this.preferences);
  SharedPreferences? preferences;

  final KeyStorage _key = KeyStorage();

  factory Storage() {
    if (_instance == null) {
      log('need call init Storage');
    }
    return _instance!;
  }

  static Future init({SharedPreferences? pres}) async {
    hadInited = true;
    if (_instance != null) {
      throw 'Storage had inited';
    }
    _instance = Storage._(pres ?? await SharedPreferences.getInstance());
    return _instance;
  }

  getInstance() {
    return _instance;
  }

  Future<void> dispose() async {
    await preferences?.remove(_key.tokenKey);
  }
}

extension TokenStrorage on Storage {
  Future<void> saveToken(String value) async {
    await preferences!.setString(_key.tokenKey, value);
  }

  Future<void> deleteToken() async {
    await preferences!.remove(_key.tokenKey);
  }

  String? get getToken => preferences!.getString(_key.tokenKey);
}
