// 首页底部播放器
import 'package:B7/global.dart';
import 'package:B7/iconfont.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/route/slide_up_down.dart';
import 'package:B7/screen/player/player_page.dart';
import 'package:B7/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomPlayer extends StatefulWidget {
  BottomPlayer({Key key}) : super(key: key);
  @override
  _BottomPlayerState createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    // 专辑封面
    String cover = globalManager.miguAudio.audioCoverUrl;
    // 音频当前播放进度
    String positionText = globalManager.positionText;
    // 音频总时长
    String durationText = globalManager.durationText;
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PlayerPage(),
        //   ),
        // );
        Navigator.push(context, SlideUpDown(PlayerPage()));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          color: Global.backgroundColor,
          border: Border(
            top: BorderSide(
              color: Global.fontSecondColor.withOpacity(.1),
              width: .5,
            ),
            bottom: BorderSide(
              color: Global.fontSecondColor.withOpacity(.1),
              width: .5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Stack(
                children: [
                  RectImage(
                    width: 50,
                    url: cover,
                    radius: 10,
                  ),
                  Positioned(
                    child: Offstage(
                      offstage: globalManager.miguAudio.audioUrl == '',
                      child: InkWell(
                        onTap: () {
                          globalManager.complete
                              ? globalManager.pause()
                              : globalManager.play();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Global.backgroundColor.withOpacity(.6),
                          ),
                          child: Center(
                            child: Icon(
                              globalManager.complete
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 34,
                              color: Global.fontColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    globalManager.miguAudio.audioName,
                    style: TextStyle(
                      color: Global.fontColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'HuiPianYuan',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Text(
                    globalManager.currentlycText,
                    style: TextStyle(
                      color: Global.fontSecondColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'HuiPianYuan',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    positionText + '/' + durationText,
                    style: TextStyle(
                      color: Global.fontSecondColor.withOpacity(.7),
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'HuiPianYuan',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Icon(IconFont.song_list, color: Global.fontColor)
          ],
        ),
      ),
    );
  }
}
