import 'package:flutter/material.dart';
import '../model/CategoryGoodList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<GategoryListData> goodLists = [];

  getMoreList(List<GategoryListData> list) {
    goodLists.addAll(list);
    notifyListeners();
  }

  getCategoryGoodsList(List<GategoryListData> list) {
    goodLists=list;
    notifyListeners();
  }

}