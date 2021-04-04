import 'package:flutter/material.dart';
import 'package:flutter_shopify/ui/views/cart/cart_view.dart';
import 'package:flutter_shopify/ui/views/home/home_view.dart';
import 'package:flutter_shopify/ui/views/more/more_view.dart';
import 'package:flutter_shopify/ui/views/profile/profile_view.dart';
import 'package:flutter_shopify/ui/views/shopping/shopping_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    ShoppingView(),
    CartView(),
    ProfileView(),
    MoreView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
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
              icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue,
        fixedColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
