import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_shop/model/cartInfo.dart';

class CartProvide with ChangeNotifier{
  String cartString = '[]';
  /// 购物商品
  List<CartInfo> cartInfoList = [];
  double allPrice = 0; /// 总价格
  int allGoodsCount = 0; /// 总数量
  bool isAllCheck = true;/// 是否全选

  void save(goodsId , goodsName , count , price , images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString  = prefs.getString('cartInfo');
    var temp = cartString == null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    // 初始化为有
    bool isHave = false;
    int ival = 0;
    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item){
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartInfoList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice = (cartInfoList[ival].price * cartInfoList[ival].count);
        allGoodsCount += cartInfoList[ival].count;
      }
      ival++;
    });

    // 如果没有
    if (!isHave) {
     Map<String , dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
     tempList.add(newGoods);
     cartInfoList.add(CartInfo.fromJson(newGoods));

     allPrice = price * count;
     allGoodsCount += count;
    }
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  void remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('cartInfo');
    cartInfoList = [];
    print('清空完成..........');
    notifyListeners();
  }

  /// 得到购物车列表
  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    cartInfoList = [];
    if (cartString == null) {
      cartInfoList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      /// 总价格
      allPrice = 0;
      /// 总数量
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((temp) {
        if (temp['isCheck']) {
          allPrice += (temp['count'] * temp['price']);
          allGoodsCount += temp['count'];
        } else {
          isAllCheck = false;
        }
        cartInfoList.add(CartInfo.fromJson(temp));
      });
    }
    notifyListeners();
  }

  deleteOneGoods(String goodsId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int deleteIndex = 0;
    tempList.forEach((temp){
      if (temp['goodsId'] == goodsId) {
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(deleteIndex);
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeCheckState(CartInfo cartItem) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((temp){
      if (temp['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  /// 点击全选按钮操作
  changeAllCheck(bool isCheck) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  /// 商品数量加减
  addOrReduceAction(var cartItem , String todo) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    for (var item in tempList) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    }

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    preferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
}