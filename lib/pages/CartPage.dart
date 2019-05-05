import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/cart_provide.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/pages/cart_page/CartItem.dart';
import 'package:flutter_shop/pages/cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provide.value<CartProvide>(context).cartInfoList;
            if (cartList.length != 0) {
              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context, child, childCategroy) {
                      cartList = childCategroy.cartInfoList;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return CartItem(cartList[index]);
                        },
                        itemCount: cartList.length,
                      );
                    },
                  ),
                  Positioned(bottom: 0, left: 0, child: CartBottom()),
                ],
              );
            } else {
              return Container(
                child: Text('购物车无任何商品快去选购吧！'),
              );
            }
          } else {
            return Text('正在加载中');
          }
        },
        future: _getCartInfo(context),
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
