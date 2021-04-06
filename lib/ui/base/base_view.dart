import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T model;

  final Widget Function(BuildContext context, T value, Widget child) builder;

  final Function(T) onModelFetchData;
  final Function(T) onUpdateWidget;

  const BaseView(
      {Key key,
      @required this.builder,
      this.onModelFetchData,
      this.onUpdateWidget,
      this.model})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  void initState() {
    if (widget.onModelFetchData != null) {
      widget.onModelFetchData(widget.model);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseView<T> oldWidget) {
    if (widget.onUpdateWidget != null) {
      widget.onUpdateWidget(widget.model);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => widget.model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
