import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  LoginViewModel() {
    _emailController.addListener(() {
      notifyListeners();
    });
    _passwordController.addListener(() {
      notifyListeners();
    });
  }

  void login(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.main);
  }

  void forgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.forgotPassword);
  }

  void register(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.register);
  }
}
