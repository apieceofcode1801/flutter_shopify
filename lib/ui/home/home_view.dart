import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/home/home_viewmodel.dart';
import 'package:flutter_shopify/ui/widgets/product_item_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeView extends StatelessWidget {
  final model = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(model.getProductQuery),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          model.loadResult(result);

          return Padding(
            padding: EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              children: model.products
                  .map((e) => ProductItemView(product: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
