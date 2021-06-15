import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';
import 'package:flutter_shopify/ui/widgets/product_item_view.dart';

import 'shopping_viewmodel.dart';

class ShoppingView extends StatelessWidget {
  final _model = ShoppingViewModel();
  ShoppingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 48) / 2;
    final itemHeight = 256 + 72;
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: BaseView<ShoppingViewModel>(
          builder: (context, model, child) => Stack(children: [
            model.state == ViewState.Initial
                ? LoadingView()
                : Padding(
                    padding: EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemCount: _model.products.length,
                      itemBuilder: (context, index) {
                        final product = _model.products[index];
                        return GridTile(
                            child: GestureDetector(
                          child: ProductItemView(product: product),
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.product,
                                arguments: product.id);
                          },
                        ));
                      },
                    ),
                  ),
            model.state == ViewState.Busy ? LoadingView() : Container()
          ]),
          model: _model,
          onModelFetchData: (model) {
            model.loadProducts();
          },
        ));
  }
}
