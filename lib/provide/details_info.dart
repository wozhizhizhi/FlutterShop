import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/ServiceMethod.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  bool isLeft = true;
  bool isRight = false;

  /// tabbar的切换方法 0 left 1 right
  changeLeftAndRight(int changeState) {
    if (changeState == 0) {
      isLeft = true;
      isRight = false;
    } else if (changeState == 1) {
      isRight = true;
      isLeft = false;
    }
    notifyListeners();
  }


  /// 从后台获取商品详细数据
  getGoodsInfo(String id) async{
    var fromData = {'goodId': id};
    await request('getGoodDetailById',fromData: fromData).then((val){
      var reponseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(reponseData);
      isLeft = true;
      notifyListeners();
    });
  }

}