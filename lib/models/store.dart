class Country {
  late int id;
  late String name;
  late double tax;
  late String code;
  late String taxName;
  List<Province> provinces = [];

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    tax = json['tax'] ?? 0.0;
    code = json['code'];
    taxName = json['tax_name'] ?? 'Tax';
    provinces =
        (json['provinces'] as List).map((e) => Province.fromJson(e)).toList();
  }
}

class Province {
  late int id;
  late int countryId;
  late String name;
  late String code;
  late double tax;
  late String taxName;
  late double taxPercentage;

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    countryId = json['country_id'] ?? -1;
    name = json['name'] ?? '';
    code = json['code'] ?? '';
    tax = json['tax'] ?? 0.0;
    taxName = json['tax_name'] ?? '';
    taxPercentage = json['tax_percentage'] ?? 0.0;
  }
}

class Shop {
  late int id;
  late String currency;
  late String moneyFormat;

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    moneyFormat =
        (json['money_format'] as String? ?? '').replaceAll('{{amount}}', '');
  }
}
