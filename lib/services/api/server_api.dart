import 'package:flutter_shopify/entities/address.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';

abstract class ServerApi {
  Future<List<Product>> getProductList(int limit);
  Future<Product> getProductDetail(String handle);
  Future<Checkout> createCheckout(List<LineItem> lineItems);
  Future<Checkout> lineItemReplace(List<LineItem> lineItems, String checkoutId);
  Future<Checkout> updateCheckoutShippingAddress(
      [String checkoutId, Address address]);
  Future<List<ShippingRate>> getShippingRates(String checkoutId);
  Future<Checkout> updateShippingRate(String checkoutId, String rateHandle);
}
