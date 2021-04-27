import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';

abstract class ServerApi {
  Future<List<Product>> getProductList(int limit);
  Future<Product> getProductDetail(String handle);
  Future<Checkout> addToCart(List<LineItem> lineItems);
  // Checkout setShippingAddress(Address address);
  // Checkout getShippingRates(String checkoutId);
  // Checkout updateShippingRate(String checkoutId, String rateHandle);
}
