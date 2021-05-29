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
            return Padding(
              padding: EdgeInsets.all(16),
              child: GridView.custom(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  childrenDelegate: SliverChildListDelegate.fixed(model.products
                      .map((e) => GestureDetector(
                            child: ProductItemView(product: e),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.product, arguments: e.id);
                            },
                          ))
                      .toList())),
              // GridView.count(
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 8,
              //   mainAxisSpacing: 8,
              //   children: model.products
              //       .map((e) => GestureDetector(
              //             child: ProductItemView(product: e),
              //             onTap: () {
              //               Navigator.of(context)
              //                   .pushNamed(Routes.product, arguments: e.id);
              //             },
              //           ))
              //       .toList(),
              // ),
            );
          },
          model: ShoppingViewModel(),
          onModelFetchData: (model) {
            model.loadProducts();
          },
        ));
  }
}
