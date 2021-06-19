import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';

class CommonTextButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const CommonTextButton({required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
        child: Text(
          title,
          style: TextStyles.buttonText,
        ));
  }
}
