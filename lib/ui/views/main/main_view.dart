import 'package:flutter/material.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/cart/cart_view.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/main/main_viewmodel.dart';
import 'package:flutter_shopify/ui/views/more/more_view.dart';
import 'package:flutter_shopify/ui/views/profile/profile_view.dart';
import 'package:flutter_shopify/ui/views/shopping/shopping_view.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    ShoppingView(),
    CartView(),
    ProfileView(),
    MoreView(),
  ];

  final List strings = [];

  @override
  Widget build(BuildContext context) {
    final checkoutModel = context.watch<CheckoutModel>();
    return BaseView<MainViewModel>(
      model: MainViewModel(),
      onModelFetchData: (model) async {
        final checkout = await model.loadCheckout();
        if (checkout != null) {
          checkoutModel.setCheckout(checkout);
        }
      },
      builder: (context, model, child) => Scaffold(
        body: _widgetOptions.elementAt(model.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white54,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Shopping',
              ),
              BottomNavigationBarItem(
                icon: (checkoutModel.checkout?.lineItems.length ?? 0) > 0
                    ? Stack(
                        children: [
                          Icon(Icons.shopping_bag),
                          Positioned(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.main),
                            width: 16,
                            height: 16,
                            child: Text(
                                '${checkoutModel.checkout?.lineItems.length}',
                                style: TextStyles.cartBadge),
                          ))
                        ],
                      )
                    : Icon(Icons.shopping_bag),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.more_vert), label: 'More'),
            ],
            currentIndex: model.selectedIndex,
            backgroundColor: Colors.blue,
            fixedColor: Colors.white,
            onTap: model.onItemTapped),
      ),
    );
  }
}
