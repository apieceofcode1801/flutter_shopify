import 'package:flutter/material.dart';
import 'package:flutter_shopify/base/router.dart';
import 'package:flutter_shopify/ui/base/base_view.dart';
import 'package:flutter_shopify/ui/views/loading/loading_viewmodel.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<LoadingViewModel>(
        builder: (context, model, child) => Container(color: Colors.green[100]),
        model: LoadingViewModel(),
        onModelFetchData: (model) async {
          await model.loadData();
          Navigator.pushReplacementNamed(context, Routes.main);
        },
      ),
    );
  }
}
