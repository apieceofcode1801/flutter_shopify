import 'package:flutter/material.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/entities/checkout.dart';
import 'package:flutter_shopify/entities/product.dart';
import 'package:flutter_shopify/services/api/server_service.dart';
import 'package:flutter_shopify/services/local_storage_service.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductDetailViewModel extends BaseViewModel {
  BuildContext context;
  late CheckoutModel checkoutModel;
  ProductDetailViewModel({required this.context}) {
    this.context = context;
    checkoutModel = context.watch<CheckoutModel>();
  }
  final serverService = ServerService.create();
  final localStorage = LocalStorageService();
  String _title = "";
  String get title => _title;

  Price? _price;
  Price? get price => _price;

  String _description = "";
  String get description => _description;

  List<Variant>? _variants;
  List<Variant>? get variants => _variants;

  Variant? _currentVariant;
  Variant? get currentVariant => _currentVariant;
  void setCurrentVariant(Variant variant) {
    _currentVariant = variant;
    notifyListeners();
  }

  List<ImageNode>? _images;
  List<ImageNode>? get images => _images;

  void loadProduct(String handle) async {
    setState(ViewState.Busy);
    final product = await serverService.getProductDetail(handle);
    if (product != null) {
      _title = product.title;
      _price = product.priceRange?.minVarianPrice;
      _description = product.description;
      _variants = product.variants;
      _currentVariant = product.variants.reduce((v1, v2) =>
          (v1.priceV2?.amount ?? 0) < (v2.priceV2?.amount ?? 0) ? v1 : v2);
      _images = product.images;
    }
    setState(ViewState.Retrieved);
  }

  void addToCart() async {
    final variant = _currentVariant;
    if (variant != null) {
      setState(ViewState.Busy);
      var lineItemInputs = [
        CheckoutLineItemInput(variantId: variant.id ?? '', quantity: 1)
      ];
      var checkout = checkoutModel.checkout;
      if (checkout != null) {
        final lineItems = checkout.lineItems;
        lineItemInputs.addAll(lineItems.map((e) => CheckoutLineItemInput(
            variantId: e.variant?.id ?? '', quantity: e.quantity)));
        checkout =
            await serverService.lineItemReplace(lineItemInputs, checkout.id);
      } else {
        checkout = await serverService
            .addToCart(CheckoutCreateInput(lineItems: lineItemInputs));
      }
      if (checkout != null) {
        LocalStorageService()
            .save(key: LocalStorageKeys.checkoutId, value: checkout.id);
        checkoutModel.setCheckout(checkout);
        showSuccessMessage("Added Product To Cart Successful");
      } else {
        showErrorMessage("Added Product To Cart Failed");
      }
      setState(ViewState.Retrieved);
    } else {
      showErrorMessage("Please select a variant");
    }
  }
}
