import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_shipping_viewmodel.dart';
import 'package:flutter_shopify/ui/views/checkout/widgets/checkout_item_selection_view.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';
import 'package:flutter_shopify/utils/app_utils.dart';
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping address',
                              style: TextStyles.titleBold,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Change',
                                  style: TextStyles.buttonText
                                      .copyWith(color: AppColors.action),
                                ))
                          ],
                        ),
                        CheckoutItemSelectionView(
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${address?.name}',
                                style: TextStyles.content,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  '${address?.address1}, ${address?.address2}, ${address?.city}, ${address?.zip}',
                                  style: TextStyles.content,
                                ),
                              ),
                              address?.phone == null
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        '${address?.phone}',
                                        style: TextStyles.content,
                                      ),
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Shipping methods',
                          style: TextStyles.titleBold,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _model.shippingRates
                              .map((e) => Column(
                                    children: [
                                      GestureDetector(
                                        child: CheckoutItemSelectionView(
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.title ?? '',
                                                  style: TextStyles.content,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    e.handle ?? '',
                                                    style: TextStyles.content,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(
                                                      '${priceWithCurrency(e.price ?? 0)}',
                                                      style: TextStyles.content,
                                                    ))
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
                          child: CommonButton('Next', action: () {}),
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
