import 'package:B7/global.dart';
import 'package:B7/manager/global_manager.dart';
import 'package:B7/screen/search/result_item.dart';
import 'package:B7/service/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  int page = 1;
  bool loading = false;
  List searchResultSongs = [];
  int resultTotalCount = 1;
  ScrollController searchScrollController = ScrollController();

  @override
  void initState() {
    searchScrollController.addListener(() {
      // 滚动当前位置
      double pixels = searchScrollController.position.pixels;
      // 页面可滚动最大尺寸
      double maxScrollExtent = searchScrollController.position.maxScrollExtent;
      if (loading) return;
      if (pixels >= maxScrollExtent) {
        search(text: searchText, page: ++page);
      }
    });
    super.initState();
  }

  void search({text, type = 'song', page = 1}) async {
    if (loading) return;
    setState(() => {loading = true});
    var res = await API.getMiGuMusicSearchListApi(
      text: text,
      type: type,
      page: page,
    );
    setState(() {
      loading = false;
      if (page == 1) searchResultSongs = [];
      searchResultSongs.addAll(res['items']);
      resultTotalCount = int.parse(res['totalCount']);
    });
  }

  List<Widget> renderSearchResult(result) {
    List<Widget> list = [];
    for (var i = 0; i < result.length; i++) {
      var item = result[i];
      list.add(ResultItem(
        id: item['id'],
        cid: item['cid'],
        contentId: item['contentId'],
        cover: item['cover'],
        songName: item['songName'],
        singers: item['singers'],
        album: item['album'],
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
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          color: Global.backgroundColor,
        ),
        child: Column(
          children: [
            SearchHeaderBar(onSearch: (text) {
              setState(() => {searchText = text});
              search(text: text);
            }),
            Expanded(
              child: SingleChildScrollView(
                controller: searchScrollController,
                child: Column(
                  children: [
                    Column(
                      children: renderSearchResult(searchResultSongs),
                    ),
                    Opacity(
                      opacity: loading ? 1 : 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            10, 10, 10, Global.media.bottom),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Global.fontSecondColor.withOpacity(.5),
                                ),
                                strokeWidth: 3,
                              ),
                              height: 12,
                              width: 12,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '正在加载更多...',
                              style: TextStyle(
                                color: Global.fontSecondColor.withOpacity(.5),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 搜索页头部
class SearchHeaderBar extends StatefulWidget {
  SearchHeaderBar({Key key, this.onSearch}) : super(key: key);
  final onSearch;
  @override
  _SearchHeaderBarState createState() => _SearchHeaderBarState();
}

class _SearchHeaderBarState extends State<SearchHeaderBar> {
  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(10, Global.media.top, 10, 10),
      decoration: BoxDecoration(
        color: Global.backgroundColor,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 10),
          Expanded(
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
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration.collapsed(
                        hintText: "歌曲、歌手搜索",
                        hintStyle: TextStyle(
                          color: Global.fontSecondColor,
                          fontSize: 12,
                        ),
                      ),
                      onSubmitted: (text) {
                        widget.onSearch(text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {},
            child: Text(
              '搜索',
              style: TextStyle(
                color: Global.fontColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
