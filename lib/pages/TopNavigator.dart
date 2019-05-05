import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 首页分类控件
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  GestureTapCallback onTap;
  TopNavigator({Key key, this.onTap, this.navigatorList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// 返回的数据大于10个的剪切
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: const EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItem(context, item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItem(BuildContext context, var item) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(width: ScreenUtil().setWidth(95),
            height: ScreenUtil().setWidth(100),
            decoration: BoxDecoration(color: Colors.pinkAccent,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(item['image']),
              ),
            ),
          ),
          Expanded(child: Text(item['mallCategoryName']),),
        ],
      ),
    );
  }
}
