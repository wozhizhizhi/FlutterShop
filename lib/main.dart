import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/IndexPage.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/Counter.dart';
import 'package:flutter_shop/provide/ChildCategory.dart';
import 'package:flutter_shop/provide/CategoryGoodsListProvide.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routers.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_shop/provide/cart_provide.dart';
import 'package:flutter_shop/provide/currentIndex.dart';

void main(){
  var counter = new Counter();
  var childCategory = new ChildCategory();
  var gategoryGoodsListProvide = new CategoryGoodsListProvide();
  var detailsInfo = new DetailsInfoProvide();
  var provides = new Providers();
  var cartProvide = new CartProvide();
  var currentIndexProvide = new CurrentIndexProvide();


  provides
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(gategoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfo))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(child: MyApp(), providers: provides));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
    return MaterialApp(
      title: '百姓生活',
      onGenerateRoute: Application.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
