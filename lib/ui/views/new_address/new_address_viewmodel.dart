import 'package:flutter/material.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/models/store.dart';
import 'package:flutter_shopify/services/network/apis/store_services.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class NewAddressViewModel extends BaseViewModel {
  List<Country> _countries = [];
  List<Country> get countries => _countries;
  Country? _currentCountry;
  Country? get currentCountry => _currentCountry;
  int? _currentCountryIndex;
  int? get currentCountryIndex => _currentCountryIndex;
  Province? _currentProvince;
  Province? get currentProvince => _currentProvince;
  int? _currentProvinceIndex;
  int? get currentProvinceIndex => _currentProvinceIndex;

  final _storeServices = StoreServices();

  CheckoutAddress get address => CheckoutAddress(
      address1: address1Controller.text,
      address2: address2Controller.text,
      firstname: firstNameController.text,
      lastname: lastNameController.text,
      city: cityController.text,
      zip: zipCodeController.text,
      country: currentCountry?.name,
      countryCode: currentCountry?.code,
      province: currentProvince?.name,
      provinceCode: currentProvince?.code);

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var address1Controller = TextEditingController();
  var address2Controller = TextEditingController();
  var cityController = TextEditingController();
  var zipCodeController = TextEditingController();

  void loadData() async {
    setState(ViewState.Initial);
    _countries = await _storeServices.getCountryList();
    setState(ViewState.Idle);
  }

  void setCurrentCountry({required String code}) {
    _currentCountry = countries.firstWhere((element) => element.code == code);
    _currentCountryIndex =
        countries.indexWhere((element) => element.code == code);
    _currentProvince = null;
    _currentProvinceIndex = null;
    notifyListeners();
  }

  void setCurrentProvince({required String code}) {
    _currentProvince = _currentCountry?.provinces
        .firstWhere((element) => element.code == code);
    _currentProvinceIndex = _currentCountry?.provinces
        .indexWhere((element) => element.code == code);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    zipCodeController.dispose();
  }
}
