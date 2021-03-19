import 'package:B7/global.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/utils/player_utils.dart';
import 'package:B7/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultItem extends StatefulWidget {
  ResultItem({
    Key key,
    this.id,
    this.cid,
    this.contentId,
    this.cover,
    this.songName,
    this.singers,
    this.album,
  }) : super(key: key);

  final String id;
  final String cid;
  final String contentId;
  final String cover;
  final String songName;
  final List singers;
  final album;

  @override
  _ResultItemState createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    return InkWell(
      onTap: () async {
        globalManager.setAudioInfo(
          miguId: widget.id,
          cid: widget.cid,
          audioName: widget.songName,
          albumName: widget.album == null ? '' : widget.album['name'],
          audioCoverUrl: widget.cover,
          singers: widget.singers,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          color: Global.backgroundColor,
        ),
        child: Row(
          children: [
            RectImage(
              width: 30,
              url: widget.cover,
              radius: 6,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.songName,
                    style: TextStyle(
                      color: Global.fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    PlayerUtils.formatSingersName(widget.singers),
                    style: TextStyle(
                      color: Global.fontSecondColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
