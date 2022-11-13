import 'package:flutter/material.dart';

/// A clock hand.
class ClockHand extends StatelessWidget {
  /// Create a const [ClockHand].
  ///
  /// All of the parameters are required and must not be null.
  const ClockHand({
    super.key,
    required this.color,
    required this.angleRadians,
    required this.length,
    required this.thickness,
    required this.onPanUpdate,
  });

  /// Hand color.
  final Color color;

  /// The angle, in radians, at which the hand is drawn.
  ///
  /// This angle is measured from the 12 o'clock position.
  final double angleRadians;

  /// The length of this clock hand.
  final double length;

  /// Thickness of the hand.
  /// For example, a clock hand to indicate hours will be thicker than the others.
  final double thickness;

  /// Callback when clock hand is panned.
  final Function(DragUpdateDetails)? onPanUpdate;

  @override
  Widget build(BuildContext context) {
    // Here, we expand the widget to fit the parent container.
    // Reason being when a widget is transformed (in this case a rotation),
    // the children will have a different render box than the
    // parent Transform widget.
    //
    // In conjunction, GestureDetector will only be check for hit tests
    // on areas where it overlaps with the parent Transform widget.
    // In this case, only in the center of the Clock widget, and not
    // the whole clock hand length.
    //
    // See https://github.com/flutter/flutter/issues/27587.
    return SizedBox.expand(
      // Center here is used to prevent Transform.rotate from getting
      // expanded to the whole widget size.
      child: Center(
        child: Transform.rotate(
          angle: angleRadians,
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(0.0, length / 2 * -1),
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              child: Container(
                width: thickness,
                height: length,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
