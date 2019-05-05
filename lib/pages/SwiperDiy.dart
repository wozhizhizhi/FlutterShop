import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/router_handler.dart';

/// 首页轮播组件
class SwiperDiy extends StatefulWidget {
  final List swiperDateList;
  final int height;
  SwiperDiy({Key key, @required this.height, this.swiperDateList})
      : super(key: key);
  @override
  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<SwiperDiy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(widget.height),
      child: Swiper(
        itemCount: widget.swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Image.network(
              "${widget.swiperDateList[index]['image']}",
              fit: BoxFit.fill,
            ),
            onTap: () {
              Application.router.navigateTo(context,
                  '/details?id=${widget.swiperDateList[index]['goodsId']}');
            },
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
