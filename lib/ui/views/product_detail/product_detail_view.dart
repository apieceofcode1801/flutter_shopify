import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/queries.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'product_detail_viewmodel.dart';

class ProductDetailView extends StatelessWidget {
  final model = ProductDetailViewModel();
  final handle;
  ProductDetailView({this.handle});
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(Queries.getProductQuery(handle))),
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

          return BaseView<ProductDetailViewModel>(
              model: model,
              builder: (context, model, child) => Scaffold(
                    appBar: AppBar(
                      title: Text(model.title),
                    ),
                    body: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      constraints: BoxConstraints.expand(),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 54),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  model.images.isNotEmpty
                                      ? Container(
                                          height:
                                              MediaQuery.of(context).size.width,
                                          child: PageView.builder(
                                            itemBuilder: (context, index) {
                                              final image = model.images[index];
                                              final width =
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width;
                                              return Container(
                                                width: width,
                                                height: width,
                                                child: Image.network(
                                                    image.originalSrc),
                                              );
                                            },
                                            itemCount: model.images.length,
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    model.title,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      '${model.currentVariant.priceV2.currency} ${model.currentVariant.priceV2.amount}'),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    'Options',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 44,
                                    child: Container(
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          final variant = model.variants[index];
                                          print(model.currentVariant.title);
                                          return GestureDetector(
                                            child: Container(
                                              color: model.currentVariant ==
                                                      variant
                                                  ? Colors.grey
                                                  : Colors.grey[50],
                                              height: 44,
                                              padding: EdgeInsets.all(8),
                                              child: Center(
                                                child: Text(
                                                  variant.title,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              model.setCurrentVariant(variant);
                                            },
                                          );
                                        },
                                        scrollDirection: Axis.horizontal,
                                        itemCount: model.variants.length,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(model.description),
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
                                  onPressed: () {},
                                ),
                              ))
                        ],
                      ),
                    ),
                  ));
        });
  }
}
