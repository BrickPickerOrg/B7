import 'package:B7/global.dart';
import 'package:B7/service/api.dart';
import 'package:B7/utils/player_utils.dart';
import 'package:B7/utils/utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MiguAudio {
  String miguId = ''; // 音频的咪咕ID
  String cid = ''; // 音频名称
  String audioName = ''; // 音频名称
  String albumName = ''; // 专辑名称
  String audioCoverUrl = ''; // 封面地址
  String audioUrl = ''; // 音频播放地址
  List singers = []; // 音频所属歌手 可能有多个
}

class GlobalManager with ChangeNotifier {
  // 注册播放器实例
  AudioPlayer audioPlayer = AudioPlayer();
  // 音频总时间
  Duration duration;
  // 音频当前时间
  Duration position = Duration(milliseconds: 0);
  // 音频是否正在播放
  bool complete = false;
  // 进度条进度值
  double sliderValue = 0;

  // 音频时长格式化
  String durationText = '--:--';
  // 播放进度格式化
  String positionText = '--:--';

  // 格式化后的歌词
  Map lycMap = {};
  // 当前时间的歌词
  String currentlycText = '歌词加载中...';

  // 咪咕音乐音频实例
  MiguAudio miguAudio = MiguAudio();

  // 播放器背景字体色
  Map<String, Color> generator = {
    'dominantColor': Global.backgroundColor,
    'vibrantColor': Global.fontColor,
  };

  var homeData; //首页数据

  // 设置当前音频信息
  void setAudioInfo({
    String miguId,
    String cid,
    String audioName,
    String albumName,
    String audioCoverUrl,
    List singers,
  }) async {
    miguAudio.miguId = miguId;
    miguAudio.cid = cid;
    miguAudio.audioName = audioName;
    miguAudio.albumName = albumName;
    miguAudio.audioCoverUrl = audioCoverUrl;
    miguAudio.singers = singers;

    String audioUrl = await API.getMiGuMusicAudioUrlApi(
      id: miguAudio.miguId,
      name: miguAudio.audioName,
      singer: PlayerUtils.formatSingersName(miguAudio.singers),
    );
    position = Duration(milliseconds: 0);
    setAudioUrl(audioUrl);
    getMiGuMusicLyric(miguAudio.cid);
    play();
    notifyListeners();
  }

  // 设置当前音频播放地址
  void setAudioUrl(audioUrl) {
    miguAudio.audioUrl = audioUrl;
  }

  // 获取歌词
  void getMiGuMusicLyric(cid) async {
    String lyric = await API.getMiGuMusicLyricApi(cid);
    lycMap = {};
    List _lyricList = lyric.split('\n').toList();
    List.generate(_lyricList.length, (i) {
      var k = _lyricList[i].length > 9 ? _lyricList[i].substring(1, 6) : '';
      var v = _lyricList[i].length > 10 ? _lyricList[i].substring(10) : '';
      lycMap[k] = v;
    });
  }

  // 播放音频文件
  play() async {
    final res = await audioPlayer.play(miguAudio.audioUrl, position: position);
    // 设置音频播放倍速
    // audioPlayer.setPlaybackRate(playbackRate: 1.0);
    if (res == 1) {
      complete = true;
      getMainColors(NetworkImage(miguAudio.audioCoverUrl));
      notifyListeners();
    }
  }

  // 暂停播放
  void pause() async {
    final res = await audioPlayer.pause();
    if (res == 1) {
      complete = false;
      notifyListeners();
    }
  }

  //停止播放
  void stop() async {
    final res = await audioPlayer.stop();
    if (res == 1) {
      complete = false;
      notifyListeners();
    }
  }

  // 调整音频播放进度
  void setSeek(seek) {
    audioPlayer.seek(seek);
  }

  // 格式化音频时间 时长/进度
  String formatTimingText(timing) {
    return timing?.toString()?.split('.')?.first?.substring(2) ?? '';
  }

  void init() async {
    homeData = await API.getMiGuMusicHomeApi();
    notifyListeners();

    // 监听播放器状态改变
    audioPlayer.onPlayerStateChanged.listen((state) {
      // 播放完毕
      if (state == AudioPlayerState.COMPLETED) {
        // 重置时长及播放状态
        position = Duration(milliseconds: 0);
        sliderValue = 0;
        complete = false;
        // 播放完毕默认单曲循环
        play();
        notifyListeners();
      }
    });

    // 当前音频总时间改变事件
    audioPlayer.onDurationChanged.listen((d) {
      duration = d;
      durationText = formatTimingText(duration);
      notifyListeners();
    });

    // 播放进度监听
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      position = p;
      positionText = formatTimingText(position);
      try {
        double _value = position.inMilliseconds / duration.inMilliseconds;
        if (_value >= 0 && _value < 1) sliderValue = _value;
      } catch (e) {
        sliderValue = 0;
      }
      // 获取当前时间点对应歌词
      String _lycText = lycMap[p?.toString()?.split('.')?.first?.substring(2)];
      currentlycText = _lycText != null ? _lycText : currentlycText;
      notifyListeners();
    });
  }

  // 获取专辑主题色
  Future<void> getMainColors(image) async {
    generator = await Utils.getMainColors(image);
    notifyListeners();
  }
}
