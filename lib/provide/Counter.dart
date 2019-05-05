import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int value = 0;
  incerement(){
    value++;
    notifyListeners();
  }
}