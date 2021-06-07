import 'dart:math';

class Product {
  late String bodyHtml;
  late DateTime createdAt;
  late DateTime publishedAt;
  late String handle;
  late int id;
  late List<ProductImage> images;
  late List<ProductOption> options;
  late String productType;
  late String status;
  late String tags;
  late String title;
  late DateTime updatedAt;
  late List<ProductVariant> variants;
  late String vendor;
  ProductImage? image;

  double get minimalPrice {
    return variants.map((e) => e.price).reduce((max));
  }

  Product.fromJson(Map<String, dynamic> json) {
    bodyHtml = json['body_html'] ?? '';
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now();
    publishedAt = json['published_at'] != null
        ? DateTime.parse(json['published_at'])
        : DateTime.now();
    handle = json['handle'] ?? '';
    id = json['id'] ?? 0;
    images = ((json['images'] as List?) != null)
        ? (json['images'] as List).map((e) => ProductImage.fromJson(e)).toList()
        : [];
    image = json['image'] != null ? ProductImage.fromJson(json['image']) : null;
    options = ((json['options'] as List?) ?? [])
        .map((e) => ProductOption.fromJson(e))
        .toList();
    productType = json['product_type'];
    status = json['status'];
    tags = json['tags'];
    title = json['title'];
    updatedAt = json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : DateTime.now();
    variants = ((json['variants'] as List?) != null)
        ? (json['variants'] as List)
            .map((e) => ProductVariant.fromJson(e))
            .toList()
        : [];
    vendor = json['vendor'] ?? 0;
  }
}

class ProductImage {
  late int id;
  late int position;
  late int productId;
  late List<dynamic> variantIds;
  late String src;
  late int width;
  late int height;

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    position = json['position'] ?? 0;
    productId = json['product_id'] ?? 0;
    variantIds = json['variant_ids'] ?? [];
    src = json['src'] ?? '';
    width = json['width'] ?? 0;
    height = json['height'] ?? 0;
  }
}

class ProductVariant {
  late String barcode;
  late double compareAtPrice; // String
  late int grams;
  late int id;
  late int imageId;
  late int inventoryItemId;
  late String inventoryPolicy;
  late int inventoryQuantity;
  late String option1;
  late String option2;
  late String option3;
  late int position;
  late double price; // String
  late int productId;
  late String sku;
  late String title;

  ProductVariant.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'] ?? '';
    compareAtPrice = double.parse(json['compare_at_price'] ?? '0');
    grams = json['grams'] ?? 0;
    id = json['id'] ?? 0;
    imageId = json['image_id'] ?? 0;
    inventoryItemId = json['inventory_item_id'] ?? 0;
    inventoryPolicy = json['inventory_policy'] ?? '';
    inventoryQuantity = json['inventory_quantity'] ?? 0;
    option1 = json['option1'] ?? '';
    option2 = json['option2'] ?? '';
    option3 = json['option3'] ?? '';
    position = json['position'] ?? 0;
    price = double.parse(json['price'] ?? 0);
    productId = json['product_id'];
    sku = json['sku'];
    title = json['title'];
  }
}

class ProductOption {
  late int id;
  late int productId;
  late String name;
  late int position;
  late List<dynamic> values;

  ProductOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'] ?? '';
    position = json['position'] ?? 0;
    values = json['values'] ?? [];
  }
}

class ProductStatus {
  static const active = 'active';
  static const archived = 'archived';
  static const draft = 'draft';
}
