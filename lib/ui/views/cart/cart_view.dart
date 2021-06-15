import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/ui_utils/dialog_manager.dart';
import 'package:flutter_shopify/ui/views/cart/cart_viewmodel.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';
import 'package:flutter_shopify/utils/app_utils.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  final _model = CartViewModel();
  @override
  Widget build(BuildContext context) {
    final checkout = context.read<CheckoutModel>().checkout;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('CART'),
      ),
      body: BaseView<CartViewModel>(
        builder: (context, model, child) => Stack(
          children: [
            model.state == ViewState.Initial
                ? LoadingView()
                : checkout != null && checkout.lineItems.length > 0
                    ? Stack(
                        children: [
                          ListView.separated(
                            itemBuilder: (context, index) {
                              if (index == checkout.lineItems.length) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: SizedBox(
                                    height: 44,
                                    child: _priceView('SUBTOTAL',
                                        checkout.subtotalPrice ?? 0),
                                  ),
                                );
                              }
                              return CartItemView(
                                  lineItem: checkout.lineItems[index],
                                  onDelete: () {
                                    DialogManager.showCommonDialog(context,
                                        message:
                                            'Are you sure you want to delete this item from Cart?',
                                        isAlert: true,
                                        actionTitle: 'Yes', action: () {
                                      _model.deleteItemAt(index);
                                    });
                                  });
                            },
                            itemCount: checkout.lineItems.length + 1,
                            separatorBuilder: (context, index) {
                              return Container(
                                color: Colors.grey[200],
                                height: 8,
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  _priceView('TOTAL', checkout.totalPrice ?? 0),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CommonButton(
                                    'Checkout'.toUpperCase(),
                                    action: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.checkoutShipping);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          'Your cart is empty.',
                          style: TextStyles.content,
                        ),
                      ),
            model.state == ViewState.Busy ? LoadingView() : Container()
          ],
        ),
        model: _model,
        onModelFetchData: (model) => model.loadCheckout(context),
      ),
    ));
  }

  Widget _priceView(String title, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.label,
        ),
        Text(
          priceWithCurrency(price),
          style: TextStyles.valueBold,
        )
      ],
    );
  }
}

class CartItemView extends StatelessWidget {
  final CheckoutLineItem lineItem;
  final Function() onDelete;
  const CartItemView({required this.lineItem, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      // height: 128,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Image.network(
                    lineItem.imageUrl ?? '',
                    width: 128,
                    height: 128,
                  )),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lineItem.title ?? '',
                        style: TextStyles.titleBold,
                      ),
                      lineItem.variantTitle?.isNotEmpty ?? false
                          ? Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                lineItem.variantTitle ?? '',
                                style: TextStyles.subTitleRegular,
                              ),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Qty: ${lineItem.quantity}',
                        style: TextStyles.subTitleLight,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        priceWithCurrency(lineItem.price ?? 0),
                        style: TextStyles.subTitleSemibold,
                      ),
                    ],
                  )),
              Expanded(child: Container())
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: 32,
              height: 32,
              child: Center(
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: onDelete,
                    color: AppColors.cancel),
              ),
            ),
          )
        ],
      ),
    );
  }
}
