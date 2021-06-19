import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController _emailNameController = TextEditingController();
  TextEditingController get emailNameController => _emailNameController;
  TextEditingController _passwordNameController = TextEditingController();
  TextEditingController get passwordNameController => _passwordNameController;

  void createAnAccount() async {}
}
