import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/main/main_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainView());
      default:
        return MaterialPageRoute(builder: (_) => MainView());
    }
  }
}

class Routes {
  static const main = '/';
  static const home = '/home';
}
