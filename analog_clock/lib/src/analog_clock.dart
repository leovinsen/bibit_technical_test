import 'package:flutter/material.dart';

import 'clock_hand.dart';
import 'constants.dart';

class AnalogClockWidget extends StatefulWidget {
  const AnalogClockWidget({super.key});

  @override
  State<AnalogClockWidget> createState() => _AnalogClockWidgetState();
}

class _AnalogClockWidgetState extends State<AnalogClockWidget> {
  static const handsLengthSeconds = 160.0;
  static const handsLengthMinutes = 140.0;
  static const handsLengthHours = 80.0;

  static const handsThicknessSeconds = 4.0;
  static const handsThicknessMinutes = 6.0;
  static const handsThicknessHours = 8.0;

  late DateTime _clockTime;

  @override
  void initState() {
    super.initState();
    _clockTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClockHand(
            color: Colors.red,
            angleRadians: _clockTime.second * radiansPerTick,
            length: handsLengthSeconds,
            thickness: handsThicknessSeconds,
            onPanUpdate: (details) {
              // TODO: implement gesture detection logic
            },
          ),
          ClockHand(
            color: Colors.black,
            angleRadians: _clockTime.minute * radiansPerTick,
            length: handsLengthMinutes,
            thickness: handsThicknessMinutes,
            onPanUpdate: (details) {
              // TODO: implement gesture detection logic
            },
          ),
          ClockHand(
            color: Colors.black,
            angleRadians: _clockTime.hour * radiansPerHour +
                (_clockTime.minute / 60) * radiansPerHour,
            length: handsLengthHours,
            thickness: handsThicknessHours,
            onPanUpdate: (details) {
              // TODO: implement gesture detection logic
            },
          ),
        ],
      ),
    );
  }
}
