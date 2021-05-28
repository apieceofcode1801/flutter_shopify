class Checkout {
  Map<String, dynamic>? appliedDiscount;
  CheckoutAddress? billingAddress;
  DateTime? createdAt;
  String? currency;
  int? customerId;
  String? discountCode;
  String? email;
  List<dynamic>? giftCards;
  late List<CheckoutLineItem> lineItems;
  Map<String, dynamic>? order;
  double? paymentDue; // String
  String? paymentUrl;
  String? phone;
  String? presentmentCurrency;
  CheckoutAddress? shippingAddress;
  bool? requiresShipping;
  CheckoutShippingRate? shippingLine;
  CheckoutShippingRate? shippingRate; // Selected shipping rate - read only
  String? sourceName;
  double? subtotalPrice; // String
  List<dynamic>? taxLines;
  bool? taxesIncluded;
  late String token;
  double? totalPrice; // String
  double? totalTax; // String
  DateTime? updatedAt;
  int? userId;
  String? webUrl;

  Checkout.fromJson(Map<String, dynamic> json) {
    appliedDiscount = json['applied_discount'] ?? {};
    billingAddress = CheckoutAddress.fromJson(json['billing_address'] ?? {});
    createdAt = DateTime.parse(json['created_at']);
    currency = json['currency'] ?? '';
    customerId = json['customer_id'];
    discountCode = json['discount_code'];
    email = json['email'];
    giftCards = json['gift_cards'] ?? [];
    lineItems = (json['line_items'] as List?) != null
        ? (json['line_items'] as List)
            .map((e) => CheckoutLineItem.fromJson(e))
            .toList()
        : [];
    order = json['order'] ?? {};
    paymentDue = double.parse(json['payment_due'] ?? 0);
    paymentUrl = json['payment_url'] ?? '';
    phone = json['phone'] ?? '';
    presentmentCurrency = json['presentment_currency'] ?? '';
    shippingAddress = CheckoutAddress.fromJson(json['shipping_address'] ?? {});
    requiresShipping = json['requires_shipping'] ?? false;
    shippingLine = CheckoutShippingRate.fromJson(json['shipping_line']);
    shippingRate = CheckoutShippingRate.fromJson(json['shipping_rate']);
    sourceName = json['source_name'] ?? '';
    subtotalPrice = double.parse(json['subtotal_price'] ?? 0);
    taxLines = json['tax_lines'] ?? [];
    taxesIncluded = json['taxes_included'] ?? false;
    token = json['token'] ?? '';
    totalPrice = double.parse(json['total_price'] ?? 0);
    totalTax = double.parse(json['total_tax'] ?? 0);
    updatedAt = DateTime.parse(json['updated_at']);
    userId = json['user_id'];
    webUrl = json['web_url'];
  }
}

class CheckoutAddress {
  late String address1;
  late String address2;
  late String city;
  String? company;
  late String country;
  late String firstname;
  late String lastname;
  late int id;
  late String phone;
  late String province;
  late String zip;
  String? provinceCode;
  String? countryCode;

  CheckoutAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'] ?? '';
    address2 = json['address2'] ?? '';
    city = json['city'] ?? '';
    company = json['company'];
    country = json['country'] ?? '';
    firstname = json['first_name'] ?? '';
    lastname = json['last_name'] ?? '';
    phone = json['phone'] ?? '';
    province = json['province'] ?? '';
    zip = json['zip'] ?? '';
    provinceCode = json['province_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() => {
        'address1': address1,
        'address2': address2,
        'city': city,
        'company': company,
        'country': country,
        'first_name': firstname,
        'last_name': lastname,
        'phone': phone,
        'province': province,
        'zip': zip,
        'province_code': provinceCode,
        'country_code': countryCode
      };
}

class CheckoutLineItem {
  String? imageUrl;
  double? compareAtPrice; // String
  int? grams;
  String? id;
  double? linePrice; // String
  double? price; // String
  int? productId;
  int? quantity; // String
  bool? requiresShipping;
  String? sku;
  String? title;
  int? variantId;
  String? variantTitle;
  String? vendor;
  List<dynamic>? appliedDiscounts;

  CheckoutLineItem.fromJson(Map<String, dynamic> json) {
    compareAtPrice = double.tryParse(json['compare_at_price'] ?? '0');
    grams = json['grams'];
    id = json['id'];
    linePrice = double.tryParse(json['line_price']);
    price = double.tryParse(json['price']);
    productId = json['product_id'];
    quantity = json['quantity'];
    requiresShipping = json['requires_shipping'] ?? false;
    sku = json['sku'];
    title = json['title'];
    variantId = json['variant_id'];
    variantTitle = json['variant_title'];
    vendor = json['vendor'];
    appliedDiscounts = json['applied_discounts'];
    imageUrl = json['image_url'];
  }
}

class CheckoutShippingRate {
  String? id;
  double? price; // String
  String? title;
  Map<String, dynamic>? checkout;
  bool? phoneRequired;
  String? handle;

  CheckoutShippingRate.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'] ?? '';
      price = double.tryParse(json['price'] ?? 0) ?? 0;
      title = json['title'] ?? '';
      checkout = json['checkout'] ?? {};
      phoneRequired = json['phone_required'] ?? false;
      handle = json['handle'] ?? '';
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'title': title,
        'checkout': checkout,
        'phone_required': phoneRequired,
        'handle': handle
      };
}
