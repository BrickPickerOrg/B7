import 'package:flutter/material.dart';

class SlideUpDown extends PageRouteBuilder {
  final Widget widget;
  SlideUpDown(this.widget)
      : super(
          transitionDuration: Duration(milliseconds: 600),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation1,
            Animation<double> animation2,
          ) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation1,
            Animation<double> animation2,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 1.0),
                end: Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation1,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        );
}
