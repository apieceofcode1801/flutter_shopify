import 'package:flutter/material.dart';

class ProductDetailImageView extends StatelessWidget {
  const ProductDetailImageView({Key? key, required this.imageURLs})
      : super(key: key);

  final List<String> imageURLs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      child: PageView.builder(
        itemBuilder: (context, index) {
          final url = imageURLs[index];
          final width = MediaQuery.of(context).size.width;
          return Container(
            width: width,
            height: width,
            child: Image.network(url),
          );
        },
        itemCount: imageURLs.length,
      ),
    );
  }
}
