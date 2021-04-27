import 'package:flutter_shopify/entities/address.dart';
import 'package:flutter_shopify/entities/product.dart';

class Checkout {
  String id;
  String email;
  String webUrl;
  List<LineItem> lineItems;
  Price subtotalV2;
  Price totalV2;
  Address shippingAddress;

  Checkout.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json["email"];
    webUrl = json["webUrl"];
    lineItems =
        (json["lineItems"]["edges"] as List).map((e) => LineItem.fromJson(e));
    subtotalV2 = Price.fromJson(json["subtotalPriceV2"]);
    totalV2 = Price.fromJson(json["totalPriceV2"]);
    shippingAddress = json["shippingAddress"] != null
        ? Address.fromJson(json["shippingAddress"])
        : null;
  }
}

class LineItem {
  String variantId;
  int quantity;

  LineItem({this.variantId, this.quantity});

  Map<String, dynamic> toJson() =>
      {"variantId": variantId, "quantity": quantity};
  LineItem.fromJson(Map<String, dynamic> json) {
    variantId = json["varianId"];
    quantity = json["quantity"];
  }
}

class ShippingRate {
  String title;
  Price priceV2;
  String handle;

  ShippingRate.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    priceV2 = Price.fromJson(json["priceV2"]);
    handle = json["handle"];
  }
}
