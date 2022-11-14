import 'dart:math';

import 'package:flutter/material.dart';

class ClockDialPainter extends CustomPainter {
  static const hourTickMarkLength = 8.0;
  static const minuteTickMarkLength = 4.0;

  static const hourTickMarkWidth = 3.0;
  static const minuteTickMarkWidth = 1.5;

  static const TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  final Paint tickPaint;
  final TextPainter textPainter;

  ClockDialPainter()
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ) {
    tickPaint.color = Colors.blueGrey;
  }

  @override
  void paint(Canvas canvas, Size size) {
    late double tickMarkLength;
    const angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    for (int i = 0; i < 60; i++) {
      final isHourTick = i % 5 == 0;
      // every 5th tick is an hour tick mark
      tickMarkLength = isHourTick ? hourTickMarkLength : minuteTickMarkLength;
      tickPaint.strokeWidth =
          isHourTick ? hourTickMarkWidth : minuteTickMarkWidth;

      canvas.drawLine(
        Offset(0.0, -radius),
        Offset(0.0, -radius + tickMarkLength),
        tickPaint,
      );

      if (isHourTick) {
        canvas.save();
        canvas.translate(0.0, -radius + 20.0);

        textPainter.text = TextSpan(
          text: '${i == 0 ? 12 : i ~/ 5}',
          style: textStyle,
        );

        // helps make the text painted vertically
        canvas.rotate(-angle * i);

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            -(textPainter.width / 2),
            -(textPainter.height / 2),
          ),
        );

        canvas.restore();
      }

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
