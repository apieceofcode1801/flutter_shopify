import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  void resetPassword() {}
}
