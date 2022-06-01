import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {
  int activeLayout = 0;

  set changeActiveLayout(int value) {
    if (activeLayout == value) return;
    activeLayout = value;
    notifyListeners();
  }
}
