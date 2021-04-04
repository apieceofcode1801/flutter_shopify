import 'package:flutter_shopify/entities/product.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final getProductQuery = """
{
  products(first: 50) {
    edges {
      node {
        id
        title
        images(first: 1) {
          edges {
            node {
              id
              originalSrc
              width
              height
            }
          }
        }
        priceRange {
          minVariantPrice {
            amount
            currencyCode
          }
          maxVariantPrice {
            amount
            currencyCode
          }
        }
        publishedAt
        description
      }
    }
  }
}
""";

class ShoppingViewModel {
  final options = QueryOptions(document: gql(getProductQuery));

  List<Product> _products = [];
  List<Product> get products => _products;

  void loadResult(QueryResult result) {
    List edges = result.data['products']['edges'];
    _products = edges.map((e) => Product.fromJson(e['node'])).toList();
  }
}
