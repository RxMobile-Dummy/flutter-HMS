import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CurvePainter extends CustomPainter {
  Color color;

  CurvePainter({this.color = CustomColors.colorRed});

  @override
  void paint(Canvas canvas, Size size) {
    Paint mPaint = Paint();
    mPaint.color = color;
    mPaint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.72);
    path.quadraticBezierTo(size.width * .25, size.height * .80, size.width * .5,
        size.height * 0.75);
    path.quadraticBezierTo(size.width * .25, size.height * .80, size.width * .5,
        size.height * 0.75);
    path.quadraticBezierTo(size.width * .80, size.height * .68, size.width * 1,
        size.height * 0.69);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvePainter1 extends CustomPainter {
  Color color;

  CurvePainter1({this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    Paint mPaint = Paint();
    mPaint.color = color;
    mPaint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.70);
    path.quadraticBezierTo(size.width * .25, size.height * .78, size.width * .5,
        size.height * 0.73);
    path.quadraticBezierTo(size.width * .25, size.height * .78, size.width * .5,
        size.height * 0.73);
    path.quadraticBezierTo(size.width * .80, size.height * .66, size.width * 1,
        size.height * 0.67);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class CurvePainter2 extends CustomPainter {
  Color color;

  CurvePainter2({this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    Paint mPaint = Paint();
    mPaint.color = color;
    mPaint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.68);
    path.quadraticBezierTo(size.width * .25, size.height * .76, size.width * .5,
        size.height * 0.71);
    path.quadraticBezierTo(size.width * .25, size.height * .76, size.width * .5,
        size.height * 0.71);
    path.quadraticBezierTo(size.width * .80, size.height * .64, size.width * 1,
        size.height * 0.65);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvePainterCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomColors.colorDarkBlue
      ..style = PaintingStyle.fill;

    final path = new Path()
      ..moveTo(size.width * .6, 0)
      ..quadraticBezierTo(
        size.width * .7,
        size.height * .08,
        size.width * .9,
        size.height * .05,
      )
      ..arcToPoint(
        Offset(
          size.width * .93,
          size.height * .15,
        ),
        radius: Radius.circular(size.height * .05),
        largeArc: true,
      )
      ..cubicTo(
        size.width * .6,
        size.height * .15,
        size.width * .5,
        size.height * .46,
        0,
        size.height * .3,
      )
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

