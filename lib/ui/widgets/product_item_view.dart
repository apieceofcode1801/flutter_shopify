import 'package:flutter/material.dart';
import 'package:flutter_shopify/entities/product.dart';

class ProductItemView extends StatelessWidget {
  final Product product;
  const ProductItemView({required this.product});
  @override
  Widget build(BuildContext context) {
    final imageWidth = (MediaQuery.of(context).size.width - 48) / 2;
    final double imageHeight = 256;
    ImageNode? image = product.images.length > 0 ? product.images.first : null;
    var scale = 1.0;
    if (image != null) {
      scale = imageWidth / image.width < imageHeight / image.height
          ? imageWidth / image.width
          : imageHeight / image.height;
    }
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
                  fit: BoxFit.fitWidth,
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
              '${product.priceRange?.minVarianPrice?.currency} ${product.priceRange?.minVarianPrice?.amount}'),
        ],
      ),
    );
  }
}
