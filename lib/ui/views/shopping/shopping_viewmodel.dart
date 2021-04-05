import 'package:flutter_shopify/base/queries.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ShoppingViewModel {
  final options = QueryOptions(document: gql(Queries.getProductsQuery(50)));

  List<Product> _products = [];
  List<Product> get products => _products;

  void loadResult(QueryResult result) {
    List edges = result.data['products']['edges'];
    _products = edges.map((e) => Product.fromJson(e['node'])).toList();
  }
}
