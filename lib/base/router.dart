import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/home/home_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(builder: (_) => HomeView());
    }
  }
}

class Routes {
  static const home = '/home';
}
