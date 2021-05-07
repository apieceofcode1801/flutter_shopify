import 'package:flutter/material.dart';
import 'package:flutter_shopify/entities/checkout.dart';

class CheckoutView extends StatelessWidget {
  final List<LineItem> lineItems;
  const CheckoutView({required this.lineItems});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Container(),
    );
  }
}
