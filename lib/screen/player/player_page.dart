import 'package:B7/global.dart';
import 'package:B7/screen/player/player_card.dart';
import 'package:B7/screen/player/player_controller.dart';
import 'package:B7/screen/player/player_header.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  PlayerPage({Key key}) : super(key: key);
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(
          15,
          Global.media.top,
          15,
          Global.media.bottom + 10,
        ),
        decoration: BoxDecoration(color: Global.backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PlayerHeader(),
            PlayerCard(),
            PlayerController(),
          ],
        ),
      ),
    );
  }
}
