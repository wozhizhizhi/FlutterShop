import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo = val.goodsInfo.data.goodInfo;

        if (goodsInfo != null) {
          return Container(
            child: Column(
              children: <Widget>[
                goodsImage(goodsInfo.image1),
                goodsName(goodsInfo.goodsName),
                goodsNumber(goodsInfo.goodsSerialNumber),
                goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice),
              ],
            ),
            color: Colors.white,
          );
        } else {
          return Container(
            child: Text('正在加载中......'),
          );
        }
      },
    );
  }

  /// 商品详情页的图片
  Widget goodsImage(String url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(750),
      fit: BoxFit.fitWidth,
    );
  }

  /// 商品详情页的名称
  Widget goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  /// 商品详情页的编号
  Widget goodsNumber(number) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号：${number}',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          color: Colors.black12,
        ),
      ),
    );
  }

  /// 商品详情页的价格页面
  Widget goodsPrice(oldPrice, newPrice) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            '¥${oldPrice}',
            style: TextStyle(color: Colors.pink),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: RichText(
              text: TextSpan(
                  text: '市场价：',
                  style: TextStyle(color: Colors.black45),
                  children: <TextSpan>[
                    TextSpan(
                      text: '¥${newPrice}',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.black12),
                    ),
                  ]),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 15, top: 10),
    );
  }
}
