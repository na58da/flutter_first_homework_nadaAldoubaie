import 'package:flutter/material.dart';

class NadaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final nadaPaint = Paint()
      ..color = const Color(0xFF35367F).withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final nadaPath = Path();
    
    nadaPath.moveTo(0, size.height * 0.7);
    
    nadaPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.55,
      size.width * 0.5,
      size.height * 0.7,
    );
    
    nadaPath.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width,
      size.height * 0.7,
    );
    
    nadaPath.lineTo(size.width, size.height);
    nadaPath.lineTo(0, size.height);
    nadaPath.close();
    
    canvas.drawPath(nadaPath, nadaPaint);

    final nadaCirclePaint = Paint()
      ..color = const Color(0xFF35367F).withOpacity(0.05)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      50,
      nadaCirclePaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.5),
      70,
      nadaCirclePaint,
    );

    final nadaDotPaint = Paint()
      ..color = const Color(0xFF35367F).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (var nadaI = 0; nadaI < 5; nadaI++) {
      for (var nadaJ = 0; nadaJ < 5; nadaJ++) {
        canvas.drawCircle(
          Offset(
            size.width * 0.1 + (nadaI * 30),
            size.height * 0.1 + (nadaJ * 30),
          ),
          2,
          nadaDotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 