import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui';

class Utils {
  // 格式化歌手名
  static getSingersName(artists) {
    var singerMap = artists.map((singer) {
      return singer['name'];
    }).toList();
    return singerMap.join("/");
  }

  // android设置沉浸状态栏。
  static setAndroidOverlayStyle(bgColor, iconBrightness) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: bgColor,
        statusBarIconBrightness: iconBrightness,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else {}
  }

  // 提取图片主色
  static Future getMainColors(image) async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      image,
      size: Size(256.0, 170.0),
      // region: newRegion,
      maximumColorCount: 20,
    );
    final Color dominantColor = paletteGenerator.dominantColor?.color;
    var gary = dominantColor.red * 0.299 +
        dominantColor.green * 0.587 +
        dominantColor.blue * 0.114;
    final Color vibrantColor =
        gary < 255 / 2 ? Color(0xFFffffff) : Color(0xFF000000);

    Map<String, Color> generator = {
      'dominantColor': dominantColor,
      'vibrantColor': vibrantColor
    };
    return generator;
  }
}
