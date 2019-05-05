import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

/// 楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodList;
  FloorContent({Key key, this.floorGoodList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _firstRow(context),
        _otherGood(context),
      ],
    );
  }

  Widget _firstRow(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodItem(context,floorGoodList[0]),
        Column(
          children: <Widget>[
            _goodItem(context,floorGoodList[1]),
            _goodItem(context,floorGoodList[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGood(BuildContext context) {
    return Row(
      children: <Widget>[
        _goodItem(context,floorGoodList[3]),
        _goodItem(context,floorGoodList[4]),
      ],
    );
  }

  Widget _goodItem(BuildContext context , Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        child: Image.network(goods['image']),
        onTap: () {
          Application.router.navigateTo(context,
              '/details?id=${goods['goodsId']}');
        },
      ),
    );
  }
}
