import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T model;

  final Widget Function(BuildContext context, T value, Widget? child) builder;

  final Function(T)? onModelFetchData;
  final Function(T)? onUpdateWidget;

  const BaseView(
      {Key? key,
      required this.builder,
      this.onModelFetchData,
      this.onUpdateWidget,
      required this.model})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  void initState() {
    final action = widget.onModelFetchData;
    if (action != null) {
      action(widget.model);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseView<T> oldWidget) {
    final action = widget.onUpdateWidget;
    if (action != null) {
      action(widget.model);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // Change to .value following this issue: https://github.com/rrousselGit/provider/issues/168
    return ChangeNotifierProvider.value(
      value: widget.model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
    // return ChangeNotifierProvider<T>(
    //   create: (context) => widget.model,
    //   child: Consumer<T>(builder: widget.builder),
    // );
  }
}
