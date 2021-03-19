import 'package:B7/global.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/service/api.dart';
import 'package:B7/utils/player_utils.dart';
import 'package:B7/widgets/loading.dart';
import 'package:B7/widgets/rect_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 歌单详情页
class PlaylistDetailPage extends StatefulWidget {
  PlaylistDetailPage({Key key, this.id}) : super(key: key);
  // 歌单ID
  final String id;

  @override
  _PlaylistDetailPageState createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  // 歌单详情数据
  var _playlistDetailInfo;

  @override
  void initState() {
    getPlaylistDetailInfo();
    super.initState();
  }

  // 获取歌单详情数据
  void getPlaylistDetailInfo() async {
    String id = widget.id;
    var res = await API.getMiGuMusicPlaylistDetailApi(id);
    setState(() => {_playlistDetailInfo = res});
  }

  List<Widget> renderPlaylist(playlist) {
    List<Widget> list = [];
    for (var i = 0; i < playlist.length; i++) {
      var item = playlist[i];
      list.add(MusicItem(
        id: item['id'],
        cid: item['cid'],
        cover: item['cover'],
        songName: item['songName'],
        singers: item['singers'],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Global.backgroundColor,
          ),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, Global.media.top, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.favorite_border),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _playlistDetailInfo == null
                      ? PageLoading()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 歌单封面
                                  RectImage(
                                    width: 120,
                                    url: _playlistDetailInfo['cover'],
                                    radius: 6,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _playlistDetailInfo['name'],
                                          style: TextStyle(
                                            color: Global.fontColor,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          _playlistDetailInfo['intro'],
                                          style: TextStyle(
                                            color: Global.fontSecondColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                '歌曲列表',
                                style: TextStyle(
                                  color: Global.fontColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Column(
                              children: renderPlaylist(
                                  _playlistDetailInfo['songList']),
                            )
                          ],
                        ),
                ),
              ),
            ],
          )),
    );
  }
}

// 歌曲列表项
class MusicItem extends StatefulWidget {
  MusicItem({
    Key key,
    this.id,
    this.cid,
    this.cover,
    this.songName,
    this.singers,
  }) : super(key: key);
  final String id;
  final String cid;
  final String cover;
  final String songName;
  final List singers;

  @override
  _MusicItemState createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalManager globalManager = Provider.of<GlobalManager>(context);
    return InkWell(
      onTap: () async {
        globalManager.setAudioInfo(
          miguId: widget.id,
          cid: widget.cid,
          audioName: widget.songName,
          albumName: '',
          audioCoverUrl: widget.cover,
          singers: widget.singers,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: [
            RectImage(
              width: 50,
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
            SizedBox(width: 15),
            InkWell(
              child: Container(
                child: Icon(
                  Icons.more_horiz,
                  color: Global.fontSecondColor,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
