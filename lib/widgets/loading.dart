import 'dart:math';
import 'package:B7/global.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class PageLoading extends StatefulWidget {
  PageLoading({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading>
    with TickerProviderStateMixin {
  AnimationController outerController;
  Animation outerAnim;

  @override
  void dispose() {
    outerController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    outerController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));

    outerAnim = Tween(begin: 0.0, end: 2.0).animate(outerController);

    outerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        outerController.reset();
        outerController.forward();
      } else if (status == AnimationStatus.dismissed) {
        outerController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!outerController.isAnimating) outerController.forward();
    return Container(
      color: Global.backgroundColor,
      child: RotationTransition(
        turns: outerAnim,
        child: Container(
          width: 100,
          height: 100,
          child: CustomPaint(
            painter: OuterPainter(),
          ),
        ),
      ),
    );
  }
}

class OuterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 画笔初始化
    Paint paint = Paint();
    // 画笔颜色
    paint.color = Global.primaryColor;
    // 画笔粗细
    paint.strokeWidth = 6;
    // 开启抗锯齿
    paint.isAntiAlias = true;
    // 默认是fill，我们不需要填充，选stroke
    paint.style = PaintingStyle.stroke;
    // 根据这个矩形来确定位置
    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    // 参数1 用来确定圆的矩形,
    // 参数2和3，分别是起始位置和扫过的角度，它原名是叫startAngle 和 sweepAngle,
    // 参数4（userCenter）false 只绘制一个弧线、如果是true，则会绘制一个扇形
    // canvas.drawArc(rect, 0.0, pi / 2, false, paint);
    canvas.drawLine(Offset(50.0, 50.0), Offset(100.0, 50.0), paint..strokeCap);
    //因为是中心对称，所以我们将位置移动180度
    canvas.drawArc(rect, pi, pi / 2, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
