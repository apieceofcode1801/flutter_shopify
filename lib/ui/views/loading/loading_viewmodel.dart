import 'package:flutter_shopify/services/network/apis/store_services.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/utils/static.dart';

class LoadingViewModel extends BaseViewModel {
  final _storeService = StoreServices();
  Future loadData() async {
    setState(ViewState.Busy);
    final shop = await _storeService.getShop();
    if (shop != null) {
      ShopConfig.currencySymbol = shop.moneyFormat;
    }
    setState(ViewState.Idle);
  }
}
