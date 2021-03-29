import 'package:B7/global.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/screen/player/bottom_player.dart';
import 'package:B7/screen/search/search_page.dart';
import 'package:B7/widgets/loading.dart';
import 'package:B7/screen/playlist/playlist_item.dart';
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
                            height: 150,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: renderPlaylistScroll(
                                    globalManager.homeData['playlist']),
                              ),
                            ),
                          )
                        : LineScalePulseOutIndicator(),
                  ],
                ),
              ),
            ),
            BottomPlayer(),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'HuiPianYuan',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
