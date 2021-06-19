import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/cart/cart_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_new_address_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_shipping_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_view.dart';
import 'package:flutter_shopify/ui/views/customer/forgot_password/forgot_password_view.dart';
import 'package:flutter_shopify/ui/views/customer/login/login_view.dart';
import 'package:flutter_shopify/ui/views/customer/register/register_view.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/loading/loading_view.dart';
import 'package:flutter_shopify/ui/views/main/main_view.dart';
import 'package:flutter_shopify/ui/views/product_detail/product_detail_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loading:
        return MaterialPageRoute(builder: (_) => LoadingView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.checkout:
        return MaterialPageRoute(builder: (_) => CheckoutView());
      case Routes.checkoutNewAddress:
        return MaterialPageRoute(builder: (_) => CheckoutNewAddressView());
      case Routes.checkoutShipping:
        return MaterialPageRoute(builder: (_) => CheckoutShippingView());
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
  static const loading = '/';
  static const login = '/login';
  static const forgotPassword = '/forgot_password';
  static const register = '/register';
  static const main = '/main';
  static const home = '/home';
  static const product = '/product';
  static const cart = '/cart';
  static const checkoutNewAddress = '/checkout_new_address';
  static const checkoutShipping = '/checkout_shipping';
  static const checkout = '/checkout';
}
