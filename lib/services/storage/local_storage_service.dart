import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  dynamic get({required String key});
  void save(String key, {dynamic value});
}

class LocalStorageService implements StorageService {
  dynamic get({required String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  void save(String key, {dynamic value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  void remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}

class LocalStorageKeys {
  static const String customerToken = 'customer_token';
  static const String checkoutId = 'checkout_id';
}
