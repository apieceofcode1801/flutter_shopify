import 'package:flutter/material.dart';
import 'package:flutter_shopify/entities/product.dart';

class ProductItemView extends StatelessWidget {
  final Product product;
  const ProductItemView({@required this.product}) : assert(product != null);
  @override
  Widget build(BuildContext context) {
    final imageWidth = (MediaQuery.of(context).size.width - 48) / 2;
    final double imageHeight = 256;
    final image = product.images.first;
    final scale = imageWidth / image.width < imageHeight / image.height
        ? imageWidth / image.width
        : imageHeight / image.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? Image.network(
                  image.originalSrc,
                  width: imageWidth,
                  height: imageHeight,
                  scale: scale,
                  fit: BoxFit.fill,
                )
              : Container(
                  height: imageHeight,
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
