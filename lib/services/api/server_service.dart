import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_api.dart';
import 'package:flutter_shopify/services/api/shopify_api.dart';

abstract class ServerServiceAbstract {
  Future<List<Product>> getProductList(int limit);
  Future<Product> getProductDetail(String handle);
  Future<Checkout> addToCart(List<LineItem> lineItems);
}

class ServerService extends ServerServiceAbstract {
  ServerApi api;

  ServerService.create() {
    api = ShopifyApi();
  }

  @override
  Future<List<Product>> getProductList(int limit) async {
    return await api.getProductList(limit);
  }

  @override
  Future<Product> getProductDetail(String handle) async {
    return await api.getProductDetail(handle);
  }

  @override
  Future<Checkout> addToCart(List<LineItem> lineItems) async {
    return await api.addToCart(lineItems);
  }
}
