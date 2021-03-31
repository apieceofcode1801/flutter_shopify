class Product {
  var id;
  var title;
  PriceRange priceRange;
  var description;
  List<ImageEdge> images;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    priceRange = PriceRange.fromJson(json['priceRange']);
    description = json['description'];
    images = (json['images']['edges'] as List)
        .map((e) => ImageEdge.fromJson(e['node']))
        .toList();
  }
}

class PriceRange {
  VarianPrice minVarianPrice;
  VarianPrice maxVarianPrice;

  PriceRange.fromJson(Map<String, dynamic> json) {
    minVarianPrice = VarianPrice.fromJson(json['minVariantPrice']);
    maxVarianPrice = VarianPrice.fromJson(json['maxVariantPrice']);
  }
}

class VarianPrice {
  double amount;
  String currency;

  VarianPrice.fromJson(Map<String, dynamic> json) {
    amount = double.parse(json['amount']);
    currency = json['currencyCode'];
  }
}

class ImageEdge {
  String id;
  String originalSrc;
  double width;
  double height;

  ImageEdge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    originalSrc = json['originalSrc'];
  }
}
