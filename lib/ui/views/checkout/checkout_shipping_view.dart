import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_shipping_viewmodel.dart';
import 'package:flutter_shopify/ui/views/checkout/widgets/checkout_item_selection_view.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';
import 'package:provider/provider.dart';

class CheckoutShippingView extends StatelessWidget {
  final _model = CheckoutShippingViewModel();
  @override
  Widget build(BuildContext context) {
    final checkoutModel = context.read<CheckoutModel>();
    final address = checkoutModel.checkout?.shippingAddress;
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
      ),
      body: BaseView<CheckoutShippingViewModel>(
        builder: (context, model, child) => Stack(
          children: [
            model.state == ViewState.Initial
                ? LoadingView()
                : Container(
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
                        Text('Shipping methods'),
                        Column(
                          children: _model.shippingRates
                              .map((e) => Column(
                                    children: [
                                      GestureDetector(
                                        child: CheckoutItemSelectionView(
                                            Column(
                                              children: [
                                                Text(e.title ?? ''),
                                                Text(e.handle ?? ''),
                                                Text('${e.price}')
                                              ],
                                            ),
                                            isSelected:
                                                _model.currentShippingRate ==
                                                    e),
                                        onTap: () {
                                          _model.selectShippingRate(e);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () async {
                            final token = checkoutModel.checkout?.token;
                            if (token != null) {
                              final checkout =
                                  await _model.updateShippingRate(token);
                              if (checkout != null) {
                                checkoutModel.setCheckout(checkout);
                              }
                            }
                          },
                          child: Text('Next'),
                        )
                      ],
                    ),
                  ),
            model.state == ViewState.Busy ? LoadingView() : Container()
          ],
        ),
        model: _model,
        onModelFetchData: (model) {
          final token = checkoutModel.checkout?.token;
          if (token != null) {
            model.loadShippingRates(token);
          }
        },
      ),
    );
  }
}
