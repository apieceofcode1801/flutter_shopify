import 'package:flutter/material.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/services/network/apis/sales_channel_services.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class CartViewModel extends BaseViewModel {
  Checkout? _checkout;
  Checkout? get checkout => _checkout;
  CheckoutModel? _checkoutModel;
  SalesChannelServices _salesChannelServices = SalesChannelServices();
  void deleteItemAt(int index) async {
    if (_checkout != null) {
      final lineItems = _checkout!.lineItems;
      lineItems.removeAt(index);
      final lineItemInputs = lineItems
          .map((e) =>
              LineItemForCheckout(variantId: e.variantId, quantity: e.quantity))
          .toList();
      setState(ViewState.Busy);
      final checkoutResult = await _salesChannelServices
          .updateCheckoutLineItems(_checkout!.token, lineItemInputs);
      if (checkoutResult != null) {
        _checkoutModel?.setCheckout(checkoutResult);
      }
      setState(ViewState.Idle);
    }
  }

  void loadCheckout(BuildContext context) {
    setState(ViewState.Initial);
    _checkoutModel = context.read<CheckoutModel>();
    _checkout = _checkoutModel?.checkout;
    setState(ViewState.Idle);
  }
}
