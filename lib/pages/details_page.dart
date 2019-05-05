import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/pages/details_page/details_top_area.dart';
import 'package:flutter_shop/pages/details_page/details_explain.dart';
import 'package:flutter_shop/pages/details_page/details_tabar.dart';
import 'package:flutter_shop/pages/details_page/details_web.dart';
import 'package:flutter_shop/pages/details_page/Details_bottom.dart';

/// 商品详情页
class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage({Key key, this.goodsId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: <Widget>[
                        DetailsTopArea(),
                        DetailsExplain(),
                        DetailsTabBar(),
                        DetailsWeb(),
                      ],
                    ),
                  ),
                  Positioned(
                    child: DetailsBottom(),
                    bottom: 0,
                    left: 0,
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("加载中"),
              );
            }
          }),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
