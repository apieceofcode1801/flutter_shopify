import 'package:flutter_shopify/models/store.dart';
import 'package:flutter_shopify/services/network/network_service.dart';

class StoreServices {
  Future<List<Country>> getCountryList() async {
    final service = NetworkService();
    service.path = '/countries.json';
    final response = await service.request(needToken: true);
    final countries = response['countries'] as List?;
    return countries?.map((e) => Country.fromJson(e)).toList() ?? [];
  }

  Future<Shop?> getShop() async {
    final service = NetworkService();
    service.path = '/shop.json';
    try {
      final response = await service.request(needToken: true);
      final shop = response['shop'];
      return Shop.fromJson(shop);
    } catch (err) {
      print(err.toString());
    }
  }
}
