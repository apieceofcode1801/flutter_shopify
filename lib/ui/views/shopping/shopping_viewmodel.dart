import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_service.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class ShoppingViewModel extends BaseViewModel {
  final serverService = ServerService.create();

  List<Product> _products = [];
  List<Product> get products => _products;

  void loadProducts() async {
    setState(ViewState.Busy);
    _products = await serverService.getProductList(50);
    setState(ViewState.Retrieved);
  }
}
