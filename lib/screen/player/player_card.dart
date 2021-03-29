import 'package:B7/global.dart';
import 'package:B7/iconfont.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({Key key}) : super(key: key);
  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    // 专辑封面
    String cover = globalManager.miguAudio.audioCoverUrl ??
        'https://data.quanziapp.com/files/sBAKxwj/AE2E4F84-35DC-48D7-B956-0921B447A883.png';
    // 音频当前播放进度
    String positionText = globalManager.positionText;
    // 音频总时长
    String durationText = globalManager.durationText;

    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Global.fontSecondColor.withOpacity(.05),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: Global.backgroundColor,
              image: DecorationImage(
                image: NetworkImage(cover),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  globalManager.miguAudio.audioName,
                  style: TextStyle(
                    color: Global.fontSecondColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'HuiPianYuan',
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  globalManager.currentlycText,
                  style: TextStyle(
                    color: Global.fontSecondColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'HuiPianYuan',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      positionText,
                      style: TextStyle(
                        color: Global.fontSecondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'HuiPianYuan',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      durationText,
                      style: TextStyle(
                        color: Global.fontSecondColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'HuiPianYuan',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        left: -18,
                        right: -18,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor:
                                Global.fontColor.withOpacity(.7), //进度条滑块左边颜色
                            inactiveTrackColor: Global.fontSecondColor
                                .withOpacity(.3), //进度条滑块右边颜色
                            thumbColor: Global.fontColor, //滑块颜色
                            overlayColor: Colors.transparent, //滑块拖拽时外圈的颜色
                            trackHeight: 3, //进度条宽度
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 5, //滑块大小
                            ),
                          ),
                          child: Slider(
                            onChanged: (v) {
                              // final p = v * playerState.duration.inMilliseconds;
                              // playerState.setSeek(Duration(milliseconds: p.round()));
                            },
                            value: globalManager.sliderValue,
                            max: 1,
                            min: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        width: 1,
                                        color: Global.fontSecondColor
                                            .withOpacity(.05),
                                      ),
                                      top: BorderSide(
                                        width: 1,
                                        color: Global.fontSecondColor
                                            .withOpacity(.05),
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      IconFont.prev,
                                      size: 35,
                                      color: Global.fontColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        width: 1,
                                        color: Global.fontSecondColor
                                            .withOpacity(.05),
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      IconFont.next,
                                      size: 35,
                                      color: Global.fontColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -5,
                        left: (MediaQuery.of(context).size.width - 150) / 2,
                        child: IconButton(
                          icon: Icon(
                            globalManager.complete
                                ? IconFont.pause
                                : IconFont.play,
                            size: 70,
                          ),
                          onPressed: () {
                            globalManager.complete
                                ? globalManager.pause()
                                : globalManager.play();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
