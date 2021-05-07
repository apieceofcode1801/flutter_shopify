import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APieceOfCode',
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.blue),
          ),
          primaryColor: Colors.blue),
      onGenerateRoute: AppRouter.generateRoute,
    );
    return ChangeNotifierProvider<CheckoutModel>(
      create: (context) => CheckoutModel(),
      child: app,
    );
  }
}
