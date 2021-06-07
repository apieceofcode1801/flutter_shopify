import 'package:flutter/material.dart';

class CheckoutItemSelectionView extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  const CheckoutItemSelectionView(this.child, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final borderSide = isSelected
        ? BorderSide(width: 1, color: Colors.black)
        : BorderSide(width: 1, color: Colors.grey);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : Colors.white,
          border: Border(
              top: borderSide,
              left: borderSide,
              bottom: borderSide,
              right: borderSide),
          borderRadius: BorderRadius.circular(4)),
      child: child,
    );
  }
}
