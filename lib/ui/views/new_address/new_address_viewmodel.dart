import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class NewAddressViewModel extends BaseViewModel {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var address1Controller = TextEditingController();
  var address2Controller = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var zipCodeController = TextEditingController();
  var emailController = TextEditingController();
}
