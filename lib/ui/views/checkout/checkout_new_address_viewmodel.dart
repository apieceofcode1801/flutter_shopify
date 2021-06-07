import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/services/network/apis/sales_channel_services.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class CheckoutNewAddressViewModel extends BaseViewModel {
  final _salesChannelService = SalesChannelServices();

  Future<Checkout?> updateCheckoutWithShippingAddress(
      String token, CheckoutAddress address) async {
    return await _salesChannelService.updateCheckoutShippingAndBillingAddress(
        token: token, shippingAddress: address, billingAddress: address);
  }
}
