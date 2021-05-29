import 'dart:convert';

import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/services/network/network_service.dart';

class LineItemForCheckout {
  final int variantId;
  final int quantity;

  LineItemForCheckout({required this.variantId, required this.quantity});

  Map<String, dynamic> toJson() =>
      {'variant_id': this.variantId, 'quantity': this.quantity};
}

class SalesChannelServices {
  Future<Checkout?> createACheckout(List<LineItemForCheckout> lineItems) async {
    final service = NetworkService();
    service.path = '/checkouts.json';
    service.method = HttpMethod.POST;
    service.body = {
      'checkout': {'line_items': lineItems.map((e) => e.toJson()).toList()}
    };
    try {
      final result = await service.request(needToken: true);
      return Checkout.fromJson(result['checkout']);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<Checkout?> retrieveACheckout(String token) async {
    final service = NetworkService();
    service.path = '/checkouts/$token.json';
    try {
      final result = await service.request(needToken: true);
      return Checkout.fromJson(result['checkout']);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<Checkout?> updateCheckoutShippingAddress(
      String token, CheckoutAddress shippingAddress) async {
    final service = NetworkService();
    service.path = '/checkouts/$token.json';
    service.method = HttpMethod.PUT;
    service.body = {
      'checkout': {'token': token, 'shipping_address': shippingAddress.toJson()}
    };
    try {
      final result = await service.request(needToken: true);
      return Checkout.fromJson(result['checkout']);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<Checkout?> updateCheckoutLineItems(
      String token, List<LineItemForCheckout> lineItems) async {
    final service = NetworkService();
    service.path = '/checkouts/$token.json';
    service.method = HttpMethod.PUT;
    service.body = {
      'checkout': {
        'token': token,
        'line_items': lineItems.map((e) => e.toJson()).toList()
      }
    };
    try {
      final result = await service.request(needToken: true);
      return Checkout.fromJson(result['checkout']);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<Checkout?> selectShippingRate(
      String token, CheckoutShippingRate rate) async {
    final service = NetworkService();
    service.path = '/checkouts/$token.json';
    service.method = HttpMethod.PUT;
    service.body = {'token': token, 'shipping_line': rate.toJson()};
    try {
      final result = await service.request(needToken: true);
      return Checkout.fromJson(result['checkout']);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<Checkout?> retrieveAvailableShippingRates(String token) async {
    final service = NetworkService();
    service.path = '/checkouts/$token/shipping_rates.json';
    try {
      final result = await service.request(needToken: true);
      return Checkout.fromJson(result['checkout']);
    } catch (err) {
      print(err.toString());
    }
  }
}
