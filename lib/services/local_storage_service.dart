import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  dynamic get({String key});
  void save({String key, String value});
}

class LocalStorageService implements StorageService {
  dynamic get({String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  void save({String key, String value}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  void remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}

class LocalStorageKeys {
  static const String customerToken = 'customer_token';
}
