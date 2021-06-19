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
  String? address1;
  String? address2;
  String? city;
  String? company;
  String? country;
  String? firstname;
  String? lastname;
  int? id;
  String? phone;
  String? province;
  String? zip;
  String? provinceCode;
  String? countryCode;
  String get name => '$firstname $lastname';

  CheckoutAddress(
      {this.address1,
      this.address2,
      this.city,
      this.company,
      this.country,
      this.countryCode,
      this.firstname,
      this.lastname,
      this.id,
      this.phone,
      this.province,
      this.zip,
      this.provinceCode});

  CheckoutAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'] ?? '';
    address2 = json['address2'] ?? '';
    city = json['city'] ?? '';
    company = json['company'];
    country = json['country'] ?? '';
    firstname = json['first_name'] ?? '';
    lastname = json['last_name'] ?? '';
    phone = json['phone'];
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
  late int quantity; // String
  bool? requiresShipping;
  String? sku;
  String? title;
  late int variantId;
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
    quantity = json['quantity'] ?? -1;
    requiresShipping = json['requires_shipping'] ?? false;
    sku = json['sku'];
    title = json['title'];
    variantId = json['variant_id'] ?? -1;
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

class CreditCard {
  String? firstName;
  String? lastName;
  String? firstDigits;
  String? lastDigits;
  String? brand;
  int? expiryMonth;
  int? expiryYear;
  String? number;

  CreditCard.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    firstDigits = json['first_digits'];
    lastDigits = json['last_digits'];
    brand = json['brand'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
    number = json['number'];
  }
}

class PaymentNextAction {
  String? redirectUrl;
  PaymentNextAction.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirect_url'];
  }
}

class Transaction {
  String? amount;
  String? amountIn;
  String? amountOut;
  String? amountRounding;
  String? authorization;
  DateTime? createdAt;
  String? currency;
  String? gateway;
  late int id;
  String? kind;
  String? message;
  String? status;
  bool test = false;

  Transaction.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountIn = json['amount_in'];
    amountOut = json['amount_out'];
    amountRounding = json['amount_rounding'];
    authorization = json['authorization'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    currency = json['currency'];
    gateway = json['gateway'];
    id = json['id'];
    kind = json['kind'];
    message = json['message'];
    status = json['status'];
    test = json['test'];
  }
}

class Payment {
  CreditCard? creditCard;
  late int id;
  String? paymentProcessingErrorMessage;
  PaymentNextAction? nextAction;
  Transaction? transaction;
  String? uniqueToken;

  Payment.fromJson(Map<String, dynamic> json) {
    creditCard = CreditCard.fromJson(json['credit_card'] ?? {});
    id = json['id'];
    paymentProcessingErrorMessage = json['payment_processing_error_message'];
    nextAction = PaymentNextAction.fromJson(json['next_action'] ?? {});
    transaction = Transaction.fromJson(json['transaction'] ?? {});
    uniqueToken = json['unique_token'];
  }
}
