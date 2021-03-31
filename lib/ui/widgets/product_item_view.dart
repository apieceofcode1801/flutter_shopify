import 'package:flutter/material.dart';
import 'package:flutter_shopify/entities/product.dart';

class ProductItemView extends StatelessWidget {
  final Product product;
  const ProductItemView({@required this.product}) : assert(product != null);
  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 48) / 2;
    final image = product.images.first;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? Image.network(
                  image.originalSrc,
                  width: width,
                  height: 256,
                  scale: width / image.width,
                  fit: BoxFit.contain,
                )
              : Container(
                  height: 256,
                ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              'Min price: ${product.priceRange.minVarianPrice.currency} ${product.priceRange.minVarianPrice.amount}'),
          const SizedBox(
            height: 8,
          ),
          Text(
              'Max price: ${product.priceRange.maxVarianPrice.currency} ${product.priceRange.maxVarianPrice.amount}')
        ],
      ),
    );
  }
}
