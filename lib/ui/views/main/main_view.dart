import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/main/main_viewmodel.dart';
import 'package:flutter_shopify/ui/views/more/more_view.dart';
import 'package:flutter_shopify/ui/views/profile/profile_view.dart';
import 'package:flutter_shopify/ui/views/shopping/shopping_view.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
import 'package:flutter_shopify/ui/views/styles/text_styles.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  final _model = MainViewModel();
  final List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    ShoppingView(),
    Container(),
    ProfileView(),
    MoreView(),
  ];

  final List strings = [];

  @override
  Widget build(BuildContext context) {
    final checkoutModel = context.watch<CheckoutModel>();
    return BaseView<MainViewModel>(
      builder: (context, model, child) => Scaffold(
        body: _widgetOptions.elementAt(_model.selectedIndex),
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
                icon: Container(),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.more_vert), label: 'More'),
            ],
            currentIndex: _model.selectedIndex,
            backgroundColor: AppColors.main,
            fixedColor: Colors.white,
            onTap: _model.onItemTapped),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.cartButton,
          onPressed: () {
            Navigator.pushNamed(context, Routes.cart);
          },
          child: (checkoutModel.checkout?.lineItems.length ?? 0) > 0
              ? Stack(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 32,
                      color: Colors.white,
                    ),
                    Positioned(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.main),
                        width: 16,
                        height: 16,
                        child: Text(
                            '${checkoutModel.checkout?.lineItems.length}',
                            style: TextStyles.cartBadge),
                      ),
                    )
                  ],
                )
              : Icon(
                  Icons.shopping_cart,
                  size: 32,
                  color: Colors.white,
                ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
      model: _model,
      onModelFetchData: (model) {
        model.loadCheckout(context);
      },
    );
  }
}
