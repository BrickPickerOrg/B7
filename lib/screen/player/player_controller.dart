import 'package:B7/iconfont.dart';
import 'package:flutter/material.dart';

class PlayerController extends StatefulWidget {
  PlayerController({Key key}) : super(key: key);
  @override
  _PlayerControllerState createState() => _PlayerControllerState();
}

class _PlayerControllerState extends State<PlayerController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ControllerItem(icon: IconFont.shunxubofang),
          ControllerItem(icon: IconFont.danquxunhuan),
          ControllerItem(icon: IconFont.liebiaoxunhuan),
          ControllerItem(icon: IconFont.heart_2_line),
          ControllerItem(icon: IconFont.song_list),
        ],
      ),
    );
  }
}

class ControllerItem extends StatefulWidget {
  ControllerItem({Key key, this.icon, this.onTap}) : super(key: key);
  final IconData icon;
  final GestureTapCallback onTap;

  @override
  _ControllerItemState createState() => _ControllerItemState();
}

class _ControllerItemState extends State<ControllerItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          child: Center(
            child: Icon(widget.icon, size: 27),
          ),
        ),
      ),
    );
  }
}
