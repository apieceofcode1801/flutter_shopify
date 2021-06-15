import 'package:flutter/material.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/models/product.dart';
import 'package:flutter_shopify/services/network/apis/product_services.dart';
import 'package:flutter_shopify/services/network/apis/sales_channel_services.dart';
import 'package:flutter_shopify/services/network/storage/local_storage_service.dart';
import 'package:flutter_shopify/ui/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _productServices = ProductServices();
  final _salesChannelServices = SalesChannelServices();
  Product? _product;
  Product? get product => _product;

  ProductVariant? _currentVariant;
  ProductVariant? get currentVariant => _currentVariant;

  void loadProduct(int id) async {
    setState(ViewState.Initial);
    _product = await _productServices.retrieveProduct(id);
    setState(ViewState.Idle);
  }

  void setCurrentVariant(ProductVariant variant) {
    _currentVariant = variant;
    notifyListeners();
  }

  void addToCart(BuildContext context) async {
    final variant = _currentVariant;
    if (variant != null) {
      setState(ViewState.Busy);
      var lineItemInputs = <LineItemForCheckout>[];
      var checkout = context.read<CheckoutModel>().checkout;
      if (checkout != null) {
        final lineItems = checkout.lineItems;
        lineItemInputs.addAll(lineItems.map((e) =>
            LineItemForCheckout(variantId: e.variantId, quantity: e.quantity)));
        final sameIndex = lineItemInputs
            .indexWhere((element) => element.variantId == variant.id);
        if (sameIndex != -1) {
          final item = lineItemInputs[sameIndex];
          item.quantity += 1;
        } else {
          lineItemInputs
              .add(LineItemForCheckout(variantId: variant.id, quantity: 1));
        }
        checkout = await _salesChannelServices.updateCheckoutLineItems(
            checkout.token, lineItemInputs);
      } else {
        checkout = await _salesChannelServices.createACheckout(lineItemInputs);
      }
      if (checkout != null) {
        LocalStorageService.instance
            .save(key: LocalStorageKeys.checkoutToken, value: checkout.token);
        context.read<CheckoutModel>().setCheckout(checkout);
        showSuccessMessage("Added Product To Cart Successful");
      } else {
        showErrorMessage("Added Product To Cart Failed");
      }
      setState(ViewState.Idle);
    } else {
      showErrorMessage("Please select a variant");
    }
  }
}
