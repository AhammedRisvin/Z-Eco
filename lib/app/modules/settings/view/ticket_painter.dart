import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/prefferences.dart';

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.06250000);
    path_0.cubicTo(0, size.height * 0.02798219, size.width * 0.01399109, 0,
        size.width * 0.03125000, 0);
    path_0.lineTo(size.width * 0.9687500, 0);
    path_0.cubicTo(size.width * 0.9860094, 0, size.width,
        size.height * 0.02798219, size.width, size.height * 0.06250000);
    path_0.lineTo(size.width, size.height * 0.3750000);
    path_0.lineTo(size.width, size.height * 0.3750000);
    path_0.cubicTo(
        size.width * 0.9250281,
        size.height * 0.3927569,
        size.width * 0.9250281,
        size.height * 0.6103681,
        size.width,
        size.height * 0.6281250);
    path_0.lineTo(size.width, size.height * 0.6281250);
    path_0.lineTo(size.width, size.height * 0.5015625);
    path_0.lineTo(size.width, size.height * 0.9375000);
    path_0.cubicTo(size.width, size.height * 0.9720187, size.width * 0.9860094,
        size.height, size.width * 0.9687500, size.height);
    path_0.lineTo(size.width * 0.03125000, size.height);
    path_0.cubicTo(size.width * 0.01399109, size.height, 0,
        size.height * 0.9720187, 0, size.height * 0.9375000);
    path_0.lineTo(0, size.height * 0.6281250);
    path_0.lineTo(0, size.height * 0.6281250);
    path_0.cubicTo(
        size.width * 0.07837969,
        size.height * 0.6168400,
        size.width * 0.07835906,
        size.height * 0.3868406,
        0,
        size.height * 0.3750000);
    path_0.lineTo(0, size.height * 0.3750000);
    path_0.lineTo(0, size.height * 0.06250000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color =
        AppPref.isDark == true ? AppConstants.containerColor : Colors.white;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
