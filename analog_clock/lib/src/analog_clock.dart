import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'clock_hand.dart';
import 'constants.dart';

// TODO: apply some polish (e.g. clock face)
class AnalogClockWidget extends StatefulWidget {
  const AnalogClockWidget({
    super.key,
    required this.onHourUpdated,
    required this.onMinuteUpdated,
    required this.onSecondUpdated,
  });

  /// triggered when the hour clock hand is moved around.
  final Function(int) onHourUpdated;

  /// triggered when the minute clock hand is moved around.
  final Function(int) onMinuteUpdated;

  /// triggered when the second clock hand is moved around.
  final Function(int) onSecondUpdated;

  @override
  State<AnalogClockWidget> createState() => _AnalogClockWidgetState();
}

class _AnalogClockWidgetState extends State<AnalogClockWidget> {
  static const handsLengthSeconds = 160.0;
  static const handsLengthMinutes = 130.0;
  static const handsLengthHours = 100.0;

  static const handsThicknessSeconds = 6.0;
  static const handsThicknessMinutes = 8.0;
  static const handsThicknessHours = 12.0;

  late DateTime _clockTime;

  @override
  void initState() {
    super.initState();
    _clockTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final dxOffset = MediaQuery.of(context).size.width / 2;
    final dyOffset = MediaQuery.of(context).size.height / 2;
    final offset = Offset(dxOffset, dyOffset);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          alignment: Alignment.center,
          width: 250,
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClockHand(
                color: Colors.red,
                angleRadians: _clockTime.second * radiansPerTick,
                length: handsLengthSeconds,
                thickness: handsThicknessSeconds,
                onPanUpdate: (details) {
                  setState(() {
                    _clockTime = DateTime(
                      _clockTime.year,
                      _clockTime.month,
                      _clockTime.day,
                      _clockTime.hour,
                      _clockTime.minute,
                      _panUpdateIntoMinutesOrSeconds(details, offset),
                    );

                    widget.onMinuteUpdated(_clockTime.second);
                  });
                },
              ),
              ClockHand(
                color: Colors.black,
                angleRadians: _clockTime.minute * radiansPerTick,
                length: handsLengthMinutes,
                thickness: handsThicknessMinutes,
                onPanUpdate: (details) {
                  setState(() {
                    _clockTime = DateTime(
                      _clockTime.year,
                      _clockTime.month,
                      _clockTime.day,
                      _clockTime.hour,
                      _panUpdateIntoMinutesOrSeconds(details, offset),
                      _clockTime.second,
                    );
                  });

                  widget.onMinuteUpdated(_clockTime.minute);
                },
              ),
              ClockHand(
                color: Colors.black,
                angleRadians: _clockTime.hour * radiansPerHour,
                length: handsLengthHours,
                thickness: handsThicknessHours,
                onPanUpdate: (details) {
                  setState(() {
                    _clockTime = DateTime(
                      _clockTime.year,
                      _clockTime.month,
                      _clockTime.day,
                      _panUpdateIntoHours(details, offset),
                      _clockTime.minute,
                      _clockTime.second,
                    );
                  });

                  widget.onHourUpdated(_clockTime.hour);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Converts [DragUpdateDetails] obtained from [GestureDragUpdateCallback]
  /// into the right minutes or seconds.
  int _panUpdateIntoMinutesOrSeconds(
      DragUpdateDetails details, Offset translation) {
    final rotationAngle = _getTranslatedAngleRadians(details, translation);

    // subtract by 15 seconds or minutes to start from 12 o'clock.
    // for [45..59]th ticks, the result will be a negative value in the range of [-1..-15].
    final ticks = rotationAngle ~/ radiansPerTick - 15;

    // to convert into [45..59], we add the negative values by 60.
    return ticks.isNegative ? ticks + 60 : ticks;
  }

  /// Converts [DragUpdateDetails] obtained from [GestureDragUpdateCallback]
  /// into the right hours.
  int _panUpdateIntoHours(DragUpdateDetails details, Offset translation) {
    final rotationAngle = _getTranslatedAngleRadians(details, translation);

    // subtract by 3 hours to start from 12 o'clock.
    // for [9..11]th hours, the result will be a negative value in the range of [-1..-3].
    final ticks = rotationAngle ~/ radiansPerHour - 3;

    // to convert into [-1..-3], we add the negative values by 12.
    return ticks.isNegative ? ticks + 12 : ticks;
  }

  /// Returns angle in radians in the range of 0 to 2 * [math.pi].
  /// Be aware that 0 here corresponds to 9 o'clock rather than 12 o'clock.
  ///
  /// [details] is the value returned from [GestureDragUpdateCallback] in [GestureDetector].
  /// [translation] is the offset needed to translate a given [details.globalPosition]
  /// to be relative from center of the screen.
  double _getTranslatedAngleRadians(
      DragUpdateDetails details, Offset translation) {
    // touch position with top left of the screen as origin.
    final tapPosition = details.globalPosition;

    // translate touch position to be relative from center
    // Similar to how an analog clock is positioned.
    final tapPositionFromCenter = tapPosition - translation;

    // convert it into unsigned number.
    return tapPositionFromCenter.direction + math.pi;
  }
}
