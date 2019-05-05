import 'package:flutter/material.dart';
import '../service/ServiceMethod.dart';
import '../pages/SwiperDiy.dart';
import 'dart:convert';
import '../pages/TopNavigator.dart';
import '../pages/AdBanner.dart';
import 'package:flutter_shop/pages/LeaderPage.dart';
import '../pages/RecommendShopPage.dart';
import 'package:flutter_shop/pages/FloorContent.dart';
import 'package:flutter_shop/pages/FloorTitle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String homePageContent = "正在获取数据";
  var fromData = {'lon': '115.02932', 'lat': '35.76189'};
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  var _future;
//  @override
//  void initState() {
//    // TODO: implement initState
//    getHomePageContent().then((val) {
//      setState(() {
//        homePageContent = val.toString();
//        print(homePageContent);
//      });
//    });
//    super.initState();
//  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = request('homePageContent', fromData: fromData);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('无忧生活+'),
        centerTitle: true,
        elevation: 0.2,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adPictrue =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommmendList =
                (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                moreInfo: '加载中',
                noMoreText: '',
                loadReadyText: '上拉加载',
              ),
              child: ListView(
                children: <Widget>[
                  new SwiperDiy(
                    swiperDateList: swiper,
                    height: 333,
                  ),
                  new TopNavigator(
                    onTap: () {},
                    navigatorList: navigatorList,
                  ),
                  AdBanner(
                    url: adPictrue,
                  ),

                  ///店长电话
                  LeaderPage(
                    leaderImage: leaderImage,
                    leaderPhone: leaderPhone,
                  ),
                  RecommendShopPage(
                    recommendList: recommmendList,
                  ),
                  FloorTitle(
                    pic: floor1Title,
                  ),
                  FloorContent(
                    floorGoodList: floor1,
                  ),
                  FloorTitle(
                    pic: floor2Title,
                  ),
                  FloorContent(
                    floorGoodList: floor2,
                  ),
                  FloorTitle(
                    pic: floor3Title,
                  ),
                  FloorContent(
                    floorGoodList: floor3,
                  ),
                  _hotGoods(),
                ],
              ),
              loadMore: () async {
                print('加载更多。。。');
                var fromData = {'page': page};
                await request('homePageBelowConten', fromData: fromData)
                    .then((val) {
                  print(val.toString());
                  var data = json.decode(val.toString());
                  List<Map> hotGoodList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(hotGoodList);
                  });
                });
              },
            );
          } else {
            return Center(
              child: Text("加载中"),
            );
          }
        },
        future: _future,
      ),
    );
  }

  // 获取热销商品数据
  void _getHotGoods() {
    var fromData = {'page': page};
    request('homePageBelowConten', fromData: fromData).then((val) {
      print(val.toString());
      var data = json.decode(val.toString());
      List<Map> hotGoodList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(hotGoodList);
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/details?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('¥${val['mallPrice']}'),
                    Text(
                      '¥${val['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Column(
      children: <Widget>[
        hotTitle,
        _wrapList(),
      ],
    );
  }
}

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  String _showText = '还没请求数据';
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          title: Text("请求远程数据"),
//        ),
//        body: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              RaisedButton(
//                onPressed: (){_jike();},
//                child: Text("请求数据"),
//              ),
//              new Text(_showText),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  void _jike(){
//    print("开始请求数据: ");
//    getHttp().then((val){
//      setState(() {
//        _showText = val['data'].toString();
//      });
//    });
//  }
//
//  Future getHttp() async{
//    try{
//      Response response;
//      Dio dio = new Dio();
//      dio.options.headers = httpheader;
//      response = await dio.post("https://time.geekbang.org/serv/v1/column/newAll");
//      print(response);
//      return response.data;
//    }catch(e){
//      return print(e);
//    }
//  }
//}

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  TextEditingController typeController = new TextEditingController();
//  String showText = "欢迎您来到美好人间";
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//        title: Text("美好人间"),
//      ),
//      body: SingleChildScrollView(
//        child: Container(
//          child: Column(
//            children: <Widget>[
//              TextField(
//                controller: typeController,
//                decoration:
//                    InputDecoration(labelText: "美女类型", helperText: "请输入你喜欢的类型"),
//                autofocus: false,
//
//                /// 自动对焦打开键盘(false不打开)
//              ),
//              RaisedButton(
//                onPressed: () {
//                  _choiceAction();
//                },
//                child: Text("选择完毕"),
//              ),
//              Text(
//                showText,
//                overflow: TextOverflow.ellipsis,
//                maxLines: 1,
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  void _choiceAction() {
//    print("开始选择你喜欢的类型............");
//    if (typeController.text.isEmpty) {
//      showDialog(
//          context: context,
//          builder: (context) {
//            new AlertDialog(
//              title: Text("美女类型不能为空"),
//            );
//          });
//    } else {
//      getHttp(typeController.text).then((val) {
//        setState(() {
//          showText = val['data']['name'];
//        });
//      });
//    }
//  }
//
//  Future getHttp(String typeText) async {
//    try {
//      Response response;
//      var data = {"name": typeText};
//      response = await new Dio().post(
//          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian",
//          queryParameters: data);
//      return response.data;
//    } catch (e) {}
//  }
//}
