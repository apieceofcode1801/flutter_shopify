// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  dynamic get({required String key});
  void save({required String key, String value});
}

class LocalStorageService implements StorageService {
  dynamic get({required String key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  void save({required String key, String? value}) async {
    if (value != null) {
      final pref = await SharedPreferences.getInstance();
      pref.setString(key, value);
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
