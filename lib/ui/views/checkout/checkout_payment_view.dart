import 'package:flutter/material.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_payment_viewmodel.dart';
import 'package:flutter_shopify/ui/views/checkout/widgets/checkout_item_selection_view.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentView extends StatelessWidget {
  final _model = CheckoutPaymentViewModel();
  @override
  Widget build(BuildContext context) {
    final checkoutModel = context.read<CheckoutModel>();
    final checkout = checkoutModel.checkout;
    final address = checkout?.billingAddress;
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
      ),
      body: BaseView<CheckoutPaymentViewModel>(
        builder: (context, model, child) => Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping address'),
                  TextButton(onPressed: () {}, child: Text('Change'))
                ],
              ),
              CheckoutItemSelectionView(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${address?.name}'),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                        '${address?.address1}, ${address?.address2}, ${address?.city}, ${address?.zip}'),
                    const SizedBox(
                      height: 16,
                    ),
                    Text('${address?.phone}')
                  ],
                ),
              ),
              Text('Payment methods'),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () async {},
                child: Text('Next'),
              )
            ],
          ),
        ),
        model: _model,
      ),
    );
  }
}
