import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/main/main_view.dart';
import 'package:flutter_shopify/ui/views/product_detail/product_detail_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.product:
        final handle = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ProductDetailView(
                  handle: handle,
                ));
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
}
