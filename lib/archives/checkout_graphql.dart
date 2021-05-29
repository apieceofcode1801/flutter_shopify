// import 'package:flutter_shopify/entities/address_graphql.dart';
// import 'package:flutter_shopify/entities/product_graphql.dart';

// class Checkout {
//   String id = "";
//   String? email;
//   String? webUrl;
//   List<LineItem> lineItems = [];
//   Price? subtotalV2;
//   Price? totalV2;
//   Address? shippingAddress;

//   Checkout.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     email = json["email"];
//     webUrl = json["webUrl"];
//     lineItems = (json["lineItems"]["edges"] as List)
//         .map((e) => LineItem.fromJson(e['node']))
//         .toList();
//     subtotalV2 = Price.fromJson(json["subtotalPriceV2"]);
//     totalV2 = Price.fromJson(json["totalPriceV2"]);
//     shippingAddress = json["shippingAddress"] != null
//         ? Address.fromJson(json["shippingAddress"])
//         : null;
//   }
// }

// class LineItem {
//   late String id = '';
//   String? title;
//   late int quantity = 0;
//   Variant? variant;

//   LineItem.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     title = json['title'];
//     quantity = json["quantity"];
//     variant = Variant.fromJson(json['variant']);
//   }
// }

// class ShippingRate {
//   String title = '';
//   late Price priceV2;
//   String handle = '';

//   ShippingRate.fromJson(Map<String, dynamic> json) {
//     title = json["title"];
//     priceV2 = Price.fromJson(json["priceV2"]);
//     handle = json["handle"];
//   }
// }

// class CheckoutCreateInput {
//   List<CheckoutLineItemInput> lineItems;

//   CheckoutCreateInput({required this.lineItems});

//   Map<String, dynamic> toJson() =>
//       {"lineItems": this.lineItems.map((e) => e.toJson()).toList()};
// }

// class CheckoutLineItemInput {
//   String variantId;
//   int quantity;

//   CheckoutLineItemInput({required this.variantId, required this.quantity});

//   Map<String, dynamic> toJson() =>
//       {"variantId": this.variantId, "quantity": quantity};
// }
