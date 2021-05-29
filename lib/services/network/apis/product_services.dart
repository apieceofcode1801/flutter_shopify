import 'package:flutter_shopify/models/product.dart';
import 'package:flutter_shopify/services/network/network_service.dart';

class ProductServices {
  Future<List<Product>> retrieveAllProduct() async {
    final networkService = NetworkService();
    networkService.path = '/products.json';
    try {
      final result = await networkService.request(needToken: true);
      final products = result['products'] as List?;
      return products?.map((e) => Product.fromJson(e)).toList() ?? [];
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  Future<Product?> retrieveProduct(int id) async {
    final service = NetworkService();
    service.path = '/products/$id.json';
    try {
      final result = await service.request(needToken: true);
      return Product.fromJson(result['product']);
    } catch (err) {
      print(err.toString());
    }
  }
}
