import 'package:flutter/material.dart';
import '../model/Category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4'; // 大类id
  String subId = ''; // 小类

  int page = 1;
  String noMoreText=''; //显示更多的标识用于表示没有数据了

  getChildCategory(List<BxMallSubDto> list , String id){
    childIndex = 0;
    categoryId = id;
    subId=''; //点击大类时，把子类ID清空

    page=1;
    noMoreText = '';

    BxMallSubDto bxMallSubDto = new BxMallSubDto();
    bxMallSubDto.mallSubId = '';
    bxMallSubDto.mallCategoryId = '00';
    bxMallSubDto.comments = null;
    bxMallSubDto.mallSubName = '全部';
    childCategoryList = [bxMallSubDto];
    
    childCategoryList.addAll(list);
    notifyListeners();
  }

  /// 改变子类索引
  changeChildIndex(index , String id) {
    page=1;
    noMoreText = '';

    childIndex = index;
    subId = id;
    notifyListeners();
  }

  // 增加page
  addPage() {
    page++;
    notifyListeners();
  }

  // noMoreText的值的改变
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}