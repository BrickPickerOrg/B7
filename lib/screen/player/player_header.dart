import 'package:B7/global.dart';
import 'package:B7/iconfont.dart';
import 'package:flutter/material.dart';

class PlayerHeader extends StatefulWidget {
  PlayerHeader({Key key}) : super(key: key);
  @override
  _PlayerHeaderState createState() => _PlayerHeaderState();
}

class _PlayerHeaderState extends State<PlayerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(IconFont.xia),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text(
            'Now Playing',
            style: TextStyle(
              color: Global.fontSecondColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'SansitaOne',
            ),
          ),
          SizedBox(width: 55),
        ],
      ),
    );
  }
}
