import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  void setState(ViewState newState) {
    if (_state != newState) {
      _state = newState;
      notifyListeners();
    }
  }

  ViewState get state => _state;
}

enum ViewState { Idle, Busy, Retrieved, Error }
