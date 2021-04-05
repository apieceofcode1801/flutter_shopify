import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/ui/widgets/product_item_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'shopping_viewmodel.dart';

class ShoppingView extends StatelessWidget {
  final model = ShoppingViewModel();
  ShoppingView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Query(
        options: model.options,
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
                  .map((e) => GestureDetector(
                        child: ProductItemView(product: e),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.product, arguments: e.handle);
                        },
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
