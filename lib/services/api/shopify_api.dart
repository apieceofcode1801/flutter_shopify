import 'package:flutter_shopify/base/config.dart';
import 'package:flutter_shopify/entities/address.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/mutations.dart';
import 'package:flutter_shopify/services/api/queries.dart';
import 'package:flutter_shopify/services/api/server_api.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart';

class ShopifyApi extends ServerApi {
  @override
  Future<Checkout?> getCheckoutById(String id) async {
    final query = Queries.getCheckoutById(id);
    final options = QueryOptions(document: gql(query));
    final result = await ShopifyClient.create().query(options);
    if (result.hasException) {
      return null;
    } else {
      final json = result.data?['node'];
      if (json != null) {
        return Checkout.fromJson(json);
      }
      return null;
    }
  }

  @override
  Future<Checkout?> createCheckout(CheckoutCreateInput input) async {
    final options = MutationOptions(
        document: gql(Mutations.checkOutCreate()),
        variables: <String, dynamic>{"input": input.toJson()});
    final result = await ShopifyClient.create().mutate(options);
    if (result.hasException) {
      return null;
    } else {
      final json = result.data?['checkoutCreate']['checkout'];
      if (json != null) {
        return Checkout.fromJson(json);
      }
      return null;
    }
  }

  @override
  Future<List<ShippingRate>?> getShippingRates(String checkoutId) {
    // TODO: implement getShippingRates
    throw UnimplementedError();
  }

  @override
  Future<Checkout?> updateCheckoutShippingAddress(
      {required String checkoutId, required Address address}) {
    // TODO: implement updateCheckoutShippingAddress
    throw UnimplementedError();
  }

  @override
  Future<Checkout?> updateShippingRate(String checkoutId, String rateHandle) {
    // TODO: implement updateShippingRate
    throw UnimplementedError();
  }

  @override
  Future<Checkout?> lineItemReplace(
      List<CheckoutLineItemInput> lineItems, String checkoutId) async {
    final variables = {
      "lineItems": lineItems.map((e) => e.toJson()).toList(),
      "checkoutId": checkoutId
    };
    final options = MutationOptions(
        document: gql(Mutations.checkoutLineItemsReplace),
        variables: variables);
    final result = await ShopifyClient.create().mutate(options);
    if (result.hasException) {
      return null;
    } else {
      return Checkout.fromJson(
          result.data?["checkoutLineItemsReplace"]['checkout']);
    }
  }

  // Future<Checkout?> updateCheckoutShippingAddress(
  //     {required String checkoutId, required Address address}) async {
  //   final options = MutationOptions(
  //       document: gql(Mutations.checkoutShippingAddressUpdate),
  //       variables: {
  //         'shippingAddress': address.toJson(),
  //         "checkoutId": checkoutId
  //       });
  //   final result = await ShopifyClient.create().mutate(options);
  //   if (result.hasException) {
  //     return null;
  //   } else {
  //     return Checkout.fromJson(
  //         result.data?['checkoutShippingAddressUpdateV2']['checkout']);
  //   }
  // }

  // @override
  // Future<List<ShippingRate>?> getShippingRates(String checkoutId) async {
  //   final options = QueryOptions(
  //       document: gql(Queries.getShippingRates(checkoutId: checkoutId)));
  //   final result = await ShopifyClient.create().query(options);
  //   if (result.hasException) {
  //     return null;
  //   } else {
  //     return (result.data?['node']['availableShippingRates']['shippingRates']
  //             as List)
  //         .map((e) => ShippingRate.fromJson(e))
  //         .toList();
  //   }
  // }

  // @override
  // Future<Checkout?> updateShippingRate(
  //     String checkoutId, String rateHandle) async {
  //   final options = MutationOptions(
  //       document: gql(Mutations.checkoutShippingLineUpdate),
  //       variables: {
  //         'checkoutId': checkoutId,
  //         'shippingRateHandle': rateHandle
  //       });

  //   final result = await ShopifyClient.create().mutate(options);
  //   if (result.hasException) {
  //     return null;
  //   } else {
  //     return Checkout.fromJson(
  //         result.data?['checkoutShippingLineUpdate']['checkout']);
  //   }
  // }

  @override
  Future<Product?> getProductDetail(String handle) async {
    final options =
        QueryOptions(document: gql(Queries.getProductQuery(handle)));
    final result = await ShopifyClient.create().query(options);
    if (!result.hasException) {
      return Product.fromJson(result.data?['productByHandle']);
    }
    return null;
  }

  @override
  Future<List<Product>?> getProductList(int limit) async {
    final options = QueryOptions(document: gql(Queries.getProductsQuery(50)));
    final result = await ShopifyClient.create().query(options);

    if (!result.hasException) {
      List edges = result.data?['products']['edges'];
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
