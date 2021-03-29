import 'package:B7/global.dart';
import 'package:B7/iconfont.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerHeader extends StatefulWidget {
  PlayerHeader({Key key}) : super(key: key);
  @override
  _PlayerHeaderState createState() => _PlayerHeaderState();
}

class _PlayerHeaderState extends State<PlayerHeader> {
  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    Color dominantColor = globalManager.generator['dominantColor'];
    Color vibrantColor = globalManager.generator['vibrantColor'];
    Color vibrantColorOpacity =
        globalManager.generator['vibrantColor'].withOpacity(.5);

    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              IconFont.xia,
              color: vibrantColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text(
            'Now Playing',
            style: TextStyle(
              color: vibrantColor,
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
