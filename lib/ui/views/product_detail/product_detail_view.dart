import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:flutter_shopify/ui/widgets/common_button.dart';
import 'package:flutter_shopify/ui/widgets/loading.dart';
import 'package:flutter_shopify/utils/static.dart';
import 'custom_views/custom_views.dart';
import 'product_detail_viewmodel.dart';

class ProductDetailView extends StatelessWidget {
  final _model = ProductDetailViewModel();
  final id;
  ProductDetailView({this.id});
  @override
  Widget build(BuildContext context) {
    final product = _model.product;
    return BaseView<ProductDetailViewModel>(
      builder: (context, model, child) => Stack(
        children: [
          Scaffold(
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
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 76),
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
                            style: TextStyles.titleBold,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${ShopConfig.currencySymbol}${_model.product?.minimalPrice}',
                            style: TextStyles.subTitleRegular,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Options',
                            style: TextStyles.header,
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
                                  print(_model.currentVariant?.title);
                                  return GestureDetector(
                                    child: Container(
                                      color: _model.currentVariant == variant
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
                                        _model.setCurrentVariant(variant);
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
                          Text(
                            'Description',
                            style: TextStyles.header,
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
                        child: CommonButton(
                          'Add To Cart',
                          margin: EdgeInsets.all(16),
                          action: () {
                            _model.addToCart(context);
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
          model.state == ViewState.Busy ? LoadingView() : Container()
        ],
      ),
      model: _model,
      onModelFetchData: (model) {
        model.loadProduct(id);
      },
    );
  }
}
