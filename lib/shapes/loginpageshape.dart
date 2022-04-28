import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class LoginPagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.49),
        Offset(size.width * 1.00, size.height * 0.49),
        [Color(0xff000000), Color(0xffffffff)],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.0018750, size.height * 0.7075000,
        size.width * 0.0035000, size.height);
    path0.quadraticBezierTo(size.width * 0.2500000, size.height * 0.7050000,
        size.width * 0.9925000, size.height * 0.6500000);
    path0.lineTo(size.width * 1, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
