import 'package:flutter/material.dart';
import 'package:flutter_shopify/models/checkout.dart';

class CheckoutModel extends ChangeNotifier {
  Checkout? checkout;
  void setCheckout(Checkout checkout) {
    this.checkout = checkout;
    notifyListeners();
  }
}
