import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/widgets/product_item_view.dart';

import 'shopping_viewmodel.dart';

class ShoppingView extends StatelessWidget {
  ShoppingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: BaseView<ShoppingViewModel>(
          builder: (context, model, child) {
            final itemWidth = (MediaQuery.of(context).size.width - 48) / 2;
            final itemHeight = 256 + 72;
            return Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: itemWidth / itemHeight,
                ),
                itemCount: model.products.length,
                itemBuilder: (context, index) {
                  final product = model.products[index];
                  return GridTile(
                      child: GestureDetector(
                    child: ProductItemView(product: product),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.product, arguments: product.id);
                    },
                  ));
                },
              ),
            );
          },
          model: ShoppingViewModel(),
          onModelFetchData: (model) {
            model.loadProducts();
          },
        ));
  }
}
