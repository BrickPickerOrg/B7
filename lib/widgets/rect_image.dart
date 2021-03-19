import 'dart:ui';
import 'package:flutter/material.dart';

class RectImage extends StatelessWidget {
  const RectImage({
    Key key,
    @required this.width,
    this.height,
    this.filter,
    @required this.url,
    @required this.radius,
  }) : super(key: key);

  final double width;
  final ImageFilter filter;
  final double height;
  final String url;
  final double radius;
  final String errorUrl =
      'https://data.quanziapp.com/files/sBAKxwj/AE2E4F84-35DC-48D7-B956-0921B447A883.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height == null ? width : height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder.png',
            fadeInDuration: const Duration(milliseconds: 500),
            image: url != '' ? url : errorUrl,
            imageErrorBuilder:
                (BuildContext context, Object error, StackTrace stackTrace) {
              return Container();
            }),
      ),
    );
  }
}
