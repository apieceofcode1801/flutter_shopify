import 'package:flutter_shopify/base/config.dart';
import 'package:flutter_shopify/base/queries.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_api.dart';
import 'package:graphql/client.dart';

class ShopifyApi extends ServerApi {
  @override
  Future<Checkout> addToCart(List<LineItem> lineItems) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductDetail(String handle) async {
    final options =
        QueryOptions(document: gql(Queries.getProductQuery(handle)));
    final result = await ShopifyClient.create().query(options);
    if (!result.hasException) {
      return Product.fromJson(result.data['productByHandle']);
    }

    return null;
  }

  @override
  Future<List<Product>> getProductList(int limit) async {
    final options = QueryOptions(document: gql(Queries.getProductsQuery(50)));
    final result = await ShopifyClient.create().query(options);

    if (!result.hasException) {
      List edges = result.data['products']['edges'];
      return edges.map((e) => Product.fromJson(e['node'])).toList();
    }
    return [];
  }
}

class ShopifyClient {
  static GraphQLClient create() {
    final _httpLink = HttpLink(baseURL);
    final _authLink = AuthLink(
        getToken: () async => accessToken,
        headerKey: "X-Shopify-Storefront-Access-Token");
    Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(link: _link, cache: GraphQLCache());
  }
}
