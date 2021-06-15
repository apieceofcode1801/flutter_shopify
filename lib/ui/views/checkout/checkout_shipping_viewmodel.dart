import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/services/network/apis/sales_channel_services.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class CheckoutShippingViewModel extends BaseViewModel {
  final _salesChannelService = SalesChannelServices();
  List<CheckoutShippingRate> _shippingRates = [];
  List<CheckoutShippingRate> get shippingRates => _shippingRates;

  CheckoutShippingRate? _currentShippingRate;
  CheckoutShippingRate? get currentShippingRate => _currentShippingRate;

  void loadShippingRates(String token) async {
    setState(ViewState.Initial);
    _shippingRates =
        await _salesChannelService.retrieveAvailableShippingRates(token) ?? [];
    setState(ViewState.Idle);
  }

  void selectShippingRate(CheckoutShippingRate rate) {
    _currentShippingRate = rate;
    notifyListeners();
  }

  Future<Checkout?> updateShippingRate(String token) async {
    if (_currentShippingRate != null) {
      return await _salesChannelService.selectShippingRate(
          token, _currentShippingRate!);
    }
  }
}
