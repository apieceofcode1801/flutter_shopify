import 'package:flutter_shopify/entities/address.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_api.dart';
import 'package:flutter_shopify/services/api/shopify_api.dart';

abstract class ServerServiceAbstract {
  Future<List<Product>> getProductList(int limit);
  Future<Product> getProductDetail(String handle);
  Future<Checkout> addToCart(List<LineItem> lineItems);
  Future<Checkout> lineItemReplace(List<LineItem> lineItems, String checkoutId);
  Future<Checkout> updateCheckoutShippingAddress(
      [String checkoutId, Address address]);
  Future<List<ShippingRate>> getShippingRates(String checkoutId);
  Future<Checkout> updateShippingRate(String checkoutId, String rateHandle);
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
    return await api.createCheckout(lineItems);
  }

  Future<Checkout> lineItemReplace(
      List<LineItem> lineItems, String checkoutId) async {
    return await api.lineItemReplace(lineItems, checkoutId);
  }

  Future<Checkout> updateCheckoutShippingAddress(
      [String checkoutId, Address address]) async {
    return api.updateCheckoutShippingAddress(checkoutId, address);
  }

  Future<List<ShippingRate>> getShippingRates(String checkoutId) async {
    return api.getShippingRates(checkoutId);
  }

  Future<Checkout> updateShippingRate(
      String checkoutId, String rateHandle) async {
    return api.updateShippingRate(checkoutId, rateHandle);
  }
}
