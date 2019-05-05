import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

/// 推荐商品控件
class RecommendShopPage extends StatelessWidget {
  final List recommendList;
  RecommendShopPage({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          Container(height: ScreenUtil().setHeight(330),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _subWidget(context,index);
              },
              itemCount: recommendList.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 5.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '推荐商品',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  /// 商品列表item
  Widget _subWidget(BuildContext context,int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,
            '/details?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.black12, width: 0.5),
          ),
          color: Colors.white,
        ),
        width: ScreenUtil().setWidth(250),
        height: ScreenUtil().setHeight(330),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black12),
            ),
          ],
        ),
      ),
    );
  }
}
