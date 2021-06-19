import 'package:flutter/material.dart';
import 'package:flutter_shopify/models/checkout.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';

import 'checkout_item_selection_view.dart';

class CheckoutAddressItemView extends StatelessWidget {
  final CheckoutAddress address;
  const CheckoutAddressItemView(this.address);
  @override
  Widget build(BuildContext context) {
    return CheckoutItemSelectionView(
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${address.name}',
            style: TextStyles.content,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${address.address1}, ${address.address2}, ${address.city}, ${address.zip}',
              style: TextStyles.content,
            ),
          ),
          address.phone == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${address.phone}',
                    style: TextStyles.content,
                  ),
                )
        ],
      ),
    );
  }
}
