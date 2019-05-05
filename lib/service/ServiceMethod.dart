import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/ServiceUrl.dart';

/// 获取首页的内容
Future request(String url , {fromData}) async{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    if (fromData == null){
      response = await dio.post(servicePath[url]);
    }
    else{
      response = await dio.post(servicePath[url],data: fromData);
    }
    if (response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口异常');
    }
  }catch(e){
    print("ERROR======>${e.toString()}");
  }
}