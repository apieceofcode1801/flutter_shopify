class Product {
  var id;
  String? handle;
  var title = '';
  PriceRange? priceRange;
  var description;
  List<ImageNode> images = [];
  List<Variant> variants = [];

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handle = json['handle'];
    title = json['title'];
    priceRange = PriceRange.fromJson(json['priceRange']);
    description = json['description'];
    images = (json['images']['edges'] as List)
        .map((e) => ImageNode.fromJson(e['node']))
        .toList();
    if (json['variants'] != null) {
      variants = (json['variants']['edges'] as List)
          .map((e) => Variant.fromJson(e['node']))
          .toList();
    }
  }
}

class PriceRange {
  Price? minVarianPrice;
  Price? maxVarianPrice;

  PriceRange.fromJson(Map<String, dynamic> json) {
    minVarianPrice = Price.fromJson(json['minVariantPrice']);
    maxVarianPrice = Price.fromJson(json['maxVariantPrice']);
  }
}

class Price {
  double? amount;
  String? currency;

  Price.fromJson(Map<String, dynamic> json) {
    amount = double.parse(json['amount']);
    currency = json['currencyCode'];
  }
}

class Variant {
  String? id;
  String? title;
  Price? priceV2;

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceV2 = Price.fromJson(json['priceV2']);
  }
}

class ImageNode {
  String id = '';
  String originalSrc = '';
  int width = 0;
  int height = 0;

  ImageNode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    originalSrc = json['originalSrc'];
  }
}
