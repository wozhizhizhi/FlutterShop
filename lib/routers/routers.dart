import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_handler.dart';

class Routers {
  static String root = '/';
  static String detailsPage = '/details';
  static void configureRouters(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context , Map<String , List<String>> params){
        print('ERROR===> ROUTER WAS NOT FOUND!!!');
    }
    );

    router.define(detailsPage, handler: detailsHandle);
  }
}