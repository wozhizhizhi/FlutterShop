import 'package:flutter/material.dart';
import 'package:flutter_shop/service/ServiceMethod.dart';
import 'dart:convert';
import '../model/Category.dart';
import '../model/CategoryGoodList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/ChildCategory.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/CategoryGoodsListProvide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 分类页面
class CategroyPage extends StatefulWidget {
  @override
  _CategroyPageState createState() => _CategroyPageState();
}

class _CategroyPageState extends State<CategroyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            CategoryLeftNav(),
            Column(
              children: <Widget>[
                CategoryRightNav(),
                GategoryGoodLists(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryLeftNav extends StatefulWidget {
  @override
  _CategoryLeftNavState createState() => _CategoryLeftNavState();
}

/// 分类左边的导航列表
class _CategoryLeftNavState extends State<CategoryLeftNav> {
  List list = [];
  int listIndex = 0;
  @override
  void initState() {
    _getCategory();
    _getGateGoodListData(null);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (listIndex == index) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var categoryId = list[index].mallCategoryId;
        var childCategoryList = list[index].bxMallSubDto;

        Provide.value<ChildCategory>(context)
            .getChildCategory(childCategoryList, categoryId);

        _getGateGoodListData(categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Colors.black12 : Colors.white,
          border: Border(
            bottom:
                BorderSide(color: Color.fromRGBO(246, 246, 246, 1), width: 1.0),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGateGoodListData(String categoryId) async {
    var fromData = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': '1',
    };

    await request('etMallGoods', fromData: fromData).then((val) {
      var data = json.decode(val.toString());
      GategoryGoodList gategoryGoodList = GategoryGoodList.fromJson(data);

      Provide.value<CategoryGoodsListProvide>(context)
          .getCategoryGoodsList(gategoryGoodList.data);
    });
  }
}

/// 分类页面右边二级导航
class CategoryRightNav extends StatefulWidget {
  @override
  _CategoryRightNavState createState() => _CategoryRightNavState();
}

class _CategoryRightNavState extends State<CategoryRightNav> {
//  List list = ['名酒', '宝丰', '北京二锅头' , '五粮液' , '茅台' , '舍得' , '小糊涂'];

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, categoryChild) {
      return Container(
        width: ScreenUtil().setWidth(570),
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: ListView.builder(
            itemCount: categoryChild.childCategoryList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _rigihtWidght(
                  index, categoryChild.childCategoryList[index]);
            }),
      );
    });
  }

  Widget _rigihtWidght(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodListData(item.mallSubId);
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        alignment: Alignment.center,
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black45),
        ),
      ),
    );
  }

  void _getGoodListData(String categorySubId) async {
    var fromData = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': '1',
    };

    await request('etMallGoods', fromData: fromData).then((val) {
      var data = json.decode(val.toString());
      GategoryGoodList gategoryGoodList = GategoryGoodList.fromJson(data);
      if (gategoryGoodList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(gategoryGoodList.data);
      }
    });
  }
}

/// 分类商品列表，可以上拉加载
class GategoryGoodLists extends StatefulWidget {
  @override
  _GategoryGoodListsState createState() => _GategoryGoodListsState();
}

class _GategoryGoodListsState extends State<GategoryGoodLists> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<RefreshFooterState> _footerKey =
        new GlobalKey<RefreshFooterState>();
    ScrollController scrollController = new ScrollController();

    /// 关于listview 如果是在row或者column中一般来说是一定要设置一个宽度或者高度
    /// 但是有时候我觉得这样给死高度或者宽度不好适配，那么有没有方法可以让listview智能得占满剩下的高度呢
    /// 发现在外部套一层Expanded可以实现
    /// 使用[Expanded]小部件可以生成[Row]，[Column]或[Flex]的子项
    /// 展开以填充主轴中的可用空间（例如，水平方向）
    return Provide<CategoryGoodsListProvide>(builder: (context, child, data) {
      try {
        if (Provide.value<ChildCategory>(context).page == 1) {
          scrollController.jumpTo(0);
        }
      } catch (e) {
        print('第一次进入页面初始化${e}');
      }
      if (data.goodLists.length > 0) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
//      height: ScreenUtil().setHeight(1000),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                moreInfo: '加载中',
                noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                loadReadyText: '上拉加载',
              ),
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return _listItem(data.goodLists, index);
                },
                itemCount: data.goodLists.length,
              ),
              loadMore: () async {
                _getMoreList();
              },
            ),
          ),
        );
      } else {
        return Container(
          child: Text('暂无数据!'),
        );
      }
    });
  }

  void _getMoreList() async {
    Provide.value<ChildCategory>(context).addPage();
    var fromData = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page,
    };

    await request('etMallGoods', fromData: fromData).then((val) {
      var data = json.decode(val.toString());
      GategoryGoodList gategoryGoodList = GategoryGoodList.fromJson(data);
      if (gategoryGoodList.data == null) {
//        Provide.value<CategoryGoodsListProvide>(context)
//            .getCategoryGoodsList([]);
        Fluttertoast.showToast(
            msg: '已经到底了',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.pink,
            textColor: Colors.white);
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(gategoryGoodList.data);
      }
    });
  }

  Widget _goodImage(List gategoryListData, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(gategoryListData[index].image),
    );
  }

  Widget _goodName(List gategoryListData, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        gategoryListData[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodPrice(List gategoryListData, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ¥${gategoryListData[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '价格: ¥${gategoryListData[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _listItem(List gategoryListData, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black26, width: 1.0))),
        child: Row(
          children: <Widget>[
            _goodImage(gategoryListData, index),
            Column(
              children: <Widget>[
                _goodName(gategoryListData, index),
                _goodPrice(
                  gategoryListData,
                  index,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
