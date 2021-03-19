import 'package:B7/service/http.dart';

class API {
  // 歌曲搜索
  static Future getMiGuMusicSearchListApi({
    text,
    type = 'song',
    page = 1,
  }) async {
    String url = "/search/all?text=$text&page=$page&type=$type";
    try {
      var response = await HttpUtils.request(url, method: HttpUtils.GET);
      return response['data'];
    } catch (e) {
      print(e);
    }
  }

  // 首页
  static Future getMiGuMusicHomeApi() async {
    String url = "/home";
    try {
      var response = await HttpUtils.request(url, method: HttpUtils.GET);
      return response['data'];
    } catch (e) {
      print(e);
    }
  }

  // 歌单详情
  static Future getMiGuMusicPlaylistDetailApi(id) async {
    String url = "/playlist/detail?id=$id";
    try {
      var response = await HttpUtils.request(url, method: HttpUtils.GET);
      return response['data'];
    } catch (e) {
      print(e);
    }
  }

  // 获取音频链接
  static Future getMiGuMusicAudioUrlApi({
    id = '',
    name = '',
    singer = '',
  }) async {
    String url = "/search/song_url?id=$id&name=$name&singer=$singer";
    try {
      var response = await HttpUtils.request(url, method: HttpUtils.GET);
      return response['data']['url'];
    } catch (e) {
      print(e);
    }
  }

  // 获取歌词
  static Future getMiGuMusicLyricApi(cid) async {
    String url = "/search/lyric?cid=$cid";
    try {
      var response = await HttpUtils.request(url, method: HttpUtils.GET);
      return response['data'];
    } catch (e) {
      print(e);
    }
  }
}
