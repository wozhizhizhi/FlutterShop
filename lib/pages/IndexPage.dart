import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/pages/CartPage.dart';
import 'package:flutter_shop/pages/CategroyPage.dart';
import 'package:flutter_shop/pages/HomePage.dart';
import 'package:flutter_shop/pages/MemberPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/currentIndex.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text("分类"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text("购物车"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text("会员中心"),
    ),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategroyPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ///设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(builder: (context, child, val) {
      int currentIndex =
          Provide.value<CurrentIndexProvide>(context).currendIndex;
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),

        /// CupertinoTabBar ios的底部tab效果
        bottomNavigationBar: CupertinoTabBar(
          items: bottomTabs,
//        type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            Provide.value<CurrentIndexProvide>(context).changeIndex(index);
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
      );
    });
  }
}

//class IndexPage extends StatefulWidget {
//  @override
//  _IndexPageState createState() => _IndexPageState();
//}
//
//class _IndexPageState extends State<IndexPage> {
//  final List<BottomNavigationBarItem> bottomTabs = [
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.search), title: Text("分类")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心")),
//  ];
//  int _selectedIndex = 0;
//  final List<Widget> tabBodies = [HomePage(), CategroyPage(), CartPage(), MemberPage()];
//  var currentPage;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    currentPage = tabBodies[_selectedIndex];
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ///设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
////    print("设备的像素密度: ${ScreenUtil.pixelRatio}");
////    print("设备的宽: ${ScreenUtil.screenWidth}");
////    print("设备的高: ${ScreenUtil.screenHeight}");
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//      /// CupertinoTabBar ios的底部tab效果
//      bottomNavigationBar: CupertinoTabBar(
//        items: bottomTabs,
////        type: BottomNavigationBarType.fixed,
//        currentIndex: _selectedIndex,
//        onTap: (index){
//          setState(() {
//            _selectedIndex = index;
//            currentPage = tabBodies[_selectedIndex];
//          });
//        },
//      ),
//      body: IndexedStack(index: _selectedIndex,children: tabBodies,),
//    );
//  }
//}
