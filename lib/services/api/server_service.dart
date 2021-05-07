import 'package:flutter_shopify/entities/address.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_api.dart';
import 'package:flutter_shopify/services/api/shopify_api.dart';

abstract class ServerServiceAbstract {
  Future<List<Product>?> getProductList(int limit);
  Future<Product?> getProductDetail(String handle);
  Future<Checkout?> addToCart(CheckoutCreateInput input);
  Future<Checkout?> lineItemReplace(
      List<CheckoutLineItemInput> lineItems, String checkoutId);
  Future<Checkout?> updateCheckoutShippingAddress(
      {required String checkoutId, required Address address});
  Future<List<ShippingRate>?> getShippingRates(String checkoutId);
  Future<Checkout?> updateShippingRate(String checkoutId, String rateHandle);
}

class ServerService extends ServerServiceAbstract {
  late ServerApi api;

  ServerService.create() {
    api = ShopifyApi();
  }

  @override
  Future<List<Product>?> getProductList(int limit) async {
    return await api.getProductList(limit);
  }

  @override
  Future<Product?> getProductDetail(String handle) async {
    return await api.getProductDetail(handle);
  }

  @override
  Future<Checkout?> addToCart(CheckoutCreateInput input) async {
    return await api.createCheckout(input);
  }

  Future<Checkout?> lineItemReplace(
      List<CheckoutLineItemInput> lineItems, String checkoutId) async {
    return await api.lineItemReplace(lineItems, checkoutId);
  }

  Future<Checkout?> updateCheckoutShippingAddress(
      {required String checkoutId, required Address address}) async {
    return api.updateCheckoutShippingAddress(
        checkoutId: checkoutId, address: address);
  }

  Future<List<ShippingRate>?> getShippingRates(String checkoutId) async {
    return api.getShippingRates(checkoutId);
  }

  Future<Checkout?> updateShippingRate(
      String checkoutId, String rateHandle) async {
    return api.updateShippingRate(checkoutId, rateHandle);
  }
}
