import 'package:flutter_shopify/models/product.dart';
import 'package:flutter_shopify/services/network/apis/product_services.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class ShoppingViewModel extends BaseViewModel {
  final _productService = ProductServices();

  List<Product> _products = [];
  List<Product> get products => _products;

  void loadProducts() async {
    setState(ViewState.Initial);
    _products = await _productService.retrieveAllProduct();
    setState(ViewState.Idle);
  }
}
