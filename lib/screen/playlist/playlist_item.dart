import 'dart:ui';
import 'package:B7/global.dart';
import 'package:B7/screen/playlist/detail_page.dart';
import 'package:flutter/material.dart';

class PlaylistItem extends StatefulWidget {
  PlaylistItem({Key key, this.cover, this.id, this.name}) : super(key: key);
  final String cover;
  final String id;
  final String name;

  @override
  _PlaylistItemState createState() => _PlaylistItemState();
}

class _PlaylistItemState extends State<PlaylistItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailPage(id: widget.id),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.cover),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Opacity(
                    opacity: .2,
                    child: Container(
                      width: 90,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          color: Global.fontColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Container(
                  width: 90,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Global.fontColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
