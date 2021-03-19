import 'package:B7/global.dart';
import 'package:B7/iconfont.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/screen/search/search_page.dart';
import 'package:B7/widgets/loading.dart';
import 'package:B7/screen/playlist/playlist_item.dart';
import 'package:B7/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> renderPlaylistScroll(playlistItems) {
    List<Widget> list = [];
    for (var i = 0; i < playlistItems.length; i++) {
      var item = playlistItems[i];
      list.add(PlaylistItem(
        id: item['id'],
        name: item['name'],
        cover: item['cover'],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(0, 0, 0, Global.media.bottom),
        decoration: BoxDecoration(
          color: Global.backgroundColor,
        ),
        child: Column(
          children: [
            HomeSearchBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    globalManager.homeData != null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: renderPlaylistScroll(
                                    globalManager.homeData['playlist']),
                              ),
                            ),
                          )
                        : PageLoading(),
                  ],
                ),
              ),
            ),
            HomePlayer(),
          ],
        ),
      ),
    );
  }
}

// 首页搜索头部
class HomeSearchBar extends StatefulWidget {
  HomeSearchBar({Key key}) : super(key: key);
  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, Global.media.top, 10, 10),
        decoration: BoxDecoration(
          color: Global.backgroundColor,
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Global.fontColor.withOpacity(.08),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.search,
                size: 20,
                color: Global.fontColor,
              ),
              SizedBox(width: 5),
              Text(
                '歌曲、歌手搜索',
                style: TextStyle(
                  color: Global.fontSecondColor,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 首页底部播放器
class HomePlayer extends StatefulWidget {
  HomePlayer({Key key}) : super(key: key);
  @override
  _HomePlayerState createState() => _HomePlayerState();
}

class _HomePlayerState extends State<HomePlayer> {
  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    // 专辑封面
    String cover = globalManager.miguAudio.audioCoverUrl;
    // 音频当前播放进度
    String positionText = globalManager.positionText;
    // 音频总时长
    String durationText = globalManager.durationText;
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
      decoration: BoxDecoration(
        color: Global.backgroundColor,
        border: Border(
          top: BorderSide(
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
          SizedBox(width: 5),
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
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Icon(IconFont.song_list, color: Global.fontColor)
        ],
      ),
    );
  }
}
