import 'package:flutter_shopify/utils/static.dart';

extension StringEx on String {
  String withCurrency() => '${ShopConfig.currencySymbol}$this';
}
