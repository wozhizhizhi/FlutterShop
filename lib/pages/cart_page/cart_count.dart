import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart_provide.dart';
import 'package:flutter_shop/model/cartInfo.dart';

class CartCount extends StatelessWidget {
  final CartInfo cartInfoModel;
  CartCount(this.cartInfoModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context , cartInfoModel),
          _countArea(context , cartInfoModel),
          _addBtn(context,cartInfoModel),
        ],
      ),
    );
  }

  /// 减少按钮
  Widget _reduceBtn(context , item) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1?Colors.white:Colors.black12,
          border: Border(
            right: BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        child: item.count > 1?Text('-'):Text(''),
      ),
    );
  }

  /// 加号按钮
  Widget _addBtn(context , item) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setWidth(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(color: Colors.black12, width: 1),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  Widget _countArea(context, item) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setWidth(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }

}
