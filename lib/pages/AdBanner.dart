import 'package:flutter/material.dart';

/// 广告组件
class AdBanner extends StatelessWidget {
  final String url;
  AdBanner({Key key , this.url}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(url),);
  }
}

