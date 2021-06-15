import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Function action;
  final bool isActive;
  final EdgeInsets margin;

  const CommonButton(this.title,
      {required this.action,
      this.isActive = true,
      this.margin = EdgeInsets.zero});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : 0.5,
      child: Container(
        width: double.infinity,
        height: 44,
        margin: margin,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.buttonBackground,
            onPrimary: AppColors.buttonText,
          ),
          onPressed: () {
            action();
          },
          child: Text(
            title,
            style: TextStyles.buttonText,
          ),
        ),
      ),
    );
  }
}
