import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

Handler detailsHandle = Handler(
  handlerFunc: (BuildContext context , Map<String , List<String>> params){
    String goodsId = params['id'].first;
    return DetailsPage(goodsId: goodsId,);
  },
);