import 'package:flutter_shopify/entities/product.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductDetailViewModel {
  String _title = "";
  String get title => _title;

  Price _price;
  Price get price => _price;

  String _description = "";
  String get description => _description;

  List<Variant> _variants;
  List<Variant> get variants => _variants;

  List<ImageNode> _images;
  List<ImageNode> get images => _images;

  void loadResult(QueryResult result) {
    final product = Product.fromJson(result.data['productByHandle']);
    _title = product.title;
    _price = product.priceRange.minVarianPrice;
    _description = product.description;
    _variants = product.variants;
    _images = product.images;
  }
}
