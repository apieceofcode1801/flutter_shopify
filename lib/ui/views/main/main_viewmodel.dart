import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/services/api/server_service.dart';
import 'package:flutter_shopify/services/local_storage_service.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class MainViewModel extends BaseViewModel {
  final serverService = ServerService.create();
  final localStorage = LocalStorageService();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<Checkout?> loadCheckout() async {
    final checkoutId =
        await localStorage.get(key: LocalStorageKeys.checkoutId) as String?;
    if (checkoutId != null) {
      final checkout = await serverService.getCheckoutById(checkoutId);
      return checkout;
    }
    return null;
  }
}
