import 'package:flutter/material.dart';

class FloorTitle extends StatelessWidget {
  final String pic;
  FloorTitle({Key key, this.pic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pic),
    );
  }
}
