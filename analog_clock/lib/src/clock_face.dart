import 'package:flutter/material.dart';

import 'clock_dial_painter.dart';

class ClockFace extends StatelessWidget {
  const ClockFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 5),
          ),
          child: Stack(
            children: <Widget>[
              // clock ticks and dials
              Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: CustomPaint(
                  painter: ClockDialPainter(),
                ),
              ),

              // center of clock
              Center(
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
