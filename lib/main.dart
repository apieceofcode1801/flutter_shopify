import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/change_notifiers/checkout_model.dart';
import 'package:flutter_shopify/ui/views/styles/colors.dart';
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
      theme: ThemeData(primaryColor: AppColors.main),
      onGenerateRoute: AppRouter.generateRoute,
    );
    return ChangeNotifierProvider<CheckoutModel>(
      create: (context) => CheckoutModel(),
      child: app,
    );
  }
}
