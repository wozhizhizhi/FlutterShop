import 'package:flutter/material.dart';
import 'package:flutter_shop/service/ServiceMethod.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request('homePageBelowConten', fromData: 1).then((val){
      print(val);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
