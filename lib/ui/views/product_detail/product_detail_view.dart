import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'custom_views/custom_views.dart';
import 'product_detail_viewmodel.dart';

class ProductDetailView extends StatelessWidget {
  final model = ProductDetailViewModel();
  final id;
  ProductDetailView({this.id});
  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailViewModel>(
      model: model,
      builder: (context, model, child) {
        final product = model.product;
        return Scaffold(
          appBar: AppBar(
            title: Text(product?.title ?? ''),
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            // constraints: BoxConstraints.expand(),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 54),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        product?.images.isNotEmpty ?? false
                            ? ProductDetailImageView(
                                imageURLs: product?.images
                                        .map((e) => e.src)
                                        .toList() ??
                                    [])
                            : Container(),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          product?.title ?? '',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${model.product?.minimalPrice}'),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Options',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 44,
                          child: Container(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                final variant = product?.variants[index];
                                print(model.currentVariant?.title);
                                return GestureDetector(
                                  child: Container(
                                    color: model.currentVariant == variant
                                        ? Colors.grey
                                        : Colors.grey[50],
                                    height: 44,
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        variant?.title ?? '',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (variant != null) {
                                      model.setCurrentVariant(variant);
                                    }
                                  },
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: product?.variants.length ?? 0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(product?.bodyHtml ?? ''),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 44,
                      child: TextButton(
                        child: Text('Add To Cart'),
                        onPressed: () {
                          model.addToCart(context);
                        },
                      ),
                    )),
                model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Container()
              ],
            ),
          ),
        );
      },
      onModelFetchData: (model) {
        model.loadProduct(id);
      },
    );
  }
}
