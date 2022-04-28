import 'package:flutter/material.dart';

class FrontPagePainter extends CustomPainter {
  @override
  paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color.fromRGBO(255, 0, 0, 1)
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(0, size.height * 0.6);
    canvas.drawPath(path, paint);
    /*  path.quadraticBezierTo(
        size.width * 1, size.height * 0.1, size.width * 1, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.height, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint); */
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
