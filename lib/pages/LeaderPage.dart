import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPage extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  LeaderPage({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Image.network(leaderImage),
        onTap: _launchURL,
      ),
    );
  }

 void _launchURL() async {
    String url = 'tel:'+leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '不能访问$url';
    }
  }
}
