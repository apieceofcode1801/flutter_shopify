import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_service.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';

class ProductDetailViewModel extends BaseViewModel {
  final serverService = ServerService.create();
  String _title = "";
  String get title => _title;

  Price _price;
  Price get price => _price;

  String _description = "";
  String get description => _description;

  List<Variant> _variants;
  List<Variant> get variants => _variants;

  Variant _currentVariant;
  Variant get currentVariant => _currentVariant;
  void setCurrentVariant(Variant variant) {
    _currentVariant = variant;
    notifyListeners();
  }

  List<ImageNode> _images;
  List<ImageNode> get images => _images;

  void loadProduct(String handle) async {
    setState(ViewState.Busy);
    final product = await serverService.getProductDetail(handle);
    if (product != null) {
      _title = product.title;
      _price = product.priceRange.minVarianPrice;
      _description = product.description;
      _variants = product.variants;
      _currentVariant = _variants
          .reduce((v1, v2) => v1.priceV2.amount < v2.priceV2.amount ? v1 : v2);
      _images = product.images;
    }
    setState(ViewState.Retrieved);
  }
}
