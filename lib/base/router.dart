import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/cart/cart_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_view.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/main/main_view.dart';
import 'package:flutter_shopify/ui/views/new_address/new_address_view.dart';
import 'package:flutter_shopify/ui/views/product_detail/product_detail_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.checkout:
        return MaterialPageRoute(builder: (_) => CheckoutView());
      case Routes.address:
        return MaterialPageRoute(builder: (_) => NewAddressView());
      case Routes.product:
        final id = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ProductDetailView(
                  id: id,
                ));
      case Routes.cart:
        return MaterialPageRoute(
            builder: (_) => CartView(), fullscreenDialog: true);
      default:
        return MaterialPageRoute(builder: (_) => MainView());
    }
  }
}

class Routes {
  static const main = '/';
  static const home = '/home';
  static const product = '/product';
  static const cart = '/cart';
  static const address = '/address';
  static const checkout = '/checkout';
}
