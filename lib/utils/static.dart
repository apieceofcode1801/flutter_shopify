class ShopConfig {
  static final ShopConfig _instance = ShopConfig._internal();
  factory ShopConfig() {
    return _instance;
  }
  ShopConfig._internal();

  static String? currencySymbol;
}
