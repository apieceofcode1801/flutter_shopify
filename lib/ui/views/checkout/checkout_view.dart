import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/queries.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/checkout/checkout_viewmodel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CheckoutView extends StatelessWidget {
  final String email;
  final List<LineItem> lineItems;
  const CheckoutView({@required this.email, @required this.lineItems});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Mutation(
          options: MutationOptions(
              document: gql(Queries.checkOutCreate(email, lineItems)),
              update: (cache, result) {
                return cache;
              }),
          builder: (runMutation, result) {
            if (result.hasException) {
              return Center(child: Text(result.exception.toString()));
            }

            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return BaseView<CheckoutViewModel>(
              model: CheckoutViewModel(),
              builder: (context, model, child) => Container(),
            );
          }),
    );
  }
}