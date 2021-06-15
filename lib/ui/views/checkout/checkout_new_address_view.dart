import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_new_address_viewmodel.dart';
import 'package:flutter_shopify/ui/views/new_address/new_address_view.dart';
import 'package:provider/provider.dart';

class CheckoutNewAddressView extends StatelessWidget {
  final _model = CheckoutNewAddressViewModel();
  @override
  Widget build(BuildContext context) {
    final checkoutModel = context.read<CheckoutModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shipping Address'),
      ),
      body: BaseView<CheckoutNewAddressViewModel>(
        builder: (context, model, child) => NewAddressView(
          actionTitle: 'Continue to checkout',
          action: (address) async {
            final token = checkoutModel.checkout?.token;
            if (token != null) {
              final checkout =
                  await model.updateCheckoutWithShippingAddress(token, address);
              if (checkout != null) {
                checkoutModel.setCheckout(checkout);
                Navigator.pushNamed(context, Routes.checkoutShipping);
              }
            }
          },
        ),
        model: _model,
      ),
    );
  }
}
