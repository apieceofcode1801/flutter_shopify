import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/ui/views/cart/cart_viewmodel.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  final viewModel = CartViewModel();
  @override
  Widget build(BuildContext context) {
    final checkout = context.read<CheckoutModel>().checkout;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: checkout != null
          ? Stack(
              children: [
                ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == checkout.lineItems.length) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total'),
                          Text(
                              '${checkout.presentmentCurrency}${checkout.totalPrice}'),
                        ],
                      );
                    }
                    return CartItemView(
                        lineItem: checkout.lineItems[index], onDelete: () {});
                  },
                  itemCount: checkout.lineItems.length + 1,
                  separatorBuilder: (context, index) {
                    if (index == checkout.lineItems.length - 1) {
                      return SizedBox(
                        height: 16,
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 44,
                      child: TextButton(
                        child: Text('Checkout'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.address);
                        },
                      ),
                    ))
              ],
            )
          : Container(),
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
      padding: EdgeInsets.all(8),
      color: Colors.red,
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
                        style: TextStyles.cartItemTitle,
                      ),
                      Text(
                        lineItem.variantTitle ?? '',
                        style: TextStyles.cartItemVariant,
                      ),
                      Text(
                        '${lineItem.linePrice}',
                        style: TextStyles.cartItemPrice,
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
                  color: Colors.green,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
