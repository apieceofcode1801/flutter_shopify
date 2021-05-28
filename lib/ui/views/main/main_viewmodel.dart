import 'package:flutter/material.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopify/services/network/apis/sales_channel_services.dart';
import 'package:flutter_shopify/services/network/storage/local_storage_service.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class MainViewModel extends BaseViewModel {
  final saleChannelService = SalesChannelServices();
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void loadCheckout(BuildContext context) async {
    final checkoutToken = await LocalStorageService.instance
        .get(key: LocalStorageKeys.checkoutToken) as String?;
    if (checkoutToken != null) {
      final checkout =
          await saleChannelService.retrieveACheckout(checkoutToken);
      if (checkout != null) {
        final checkoutModel = context.read<CheckoutModel>();
        checkoutModel.setCheckout(checkout);
      }
    }
  }
}
