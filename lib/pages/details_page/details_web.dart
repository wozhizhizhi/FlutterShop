import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        bool isLeft = val.isLeft;
        if (isLeft) {
          return Html(data: goodsDetails);
        } else {
          return Container(
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }
}
