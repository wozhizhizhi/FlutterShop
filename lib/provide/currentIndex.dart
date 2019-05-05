import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currendIndex = 0;

  changeIndex(int newIndex) {
    currendIndex = newIndex;
    notifyListeners();
  }

}