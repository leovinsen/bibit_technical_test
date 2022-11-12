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
    return Transform.rotate(
      angle: angleRadians,
      alignment: Alignment.center,
      child: Transform.translate(
        // Translate by 50% of the hand's length
        offset: Offset(0.0, length / 2 * -1),
        child: GestureDetector(
          onPanUpdate: onPanUpdate,
          behavior: HitTestBehavior.translucent,
          child: Container(
            width: thickness,
            height: length,
            color: color,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// /// A clock hand.
// class ClockHand extends StatelessWidget {
//   /// Create a const [ClockHand].
//   ///
//   /// All of the parameters are required and must not be null.
//   const ClockHand({
//     super.key,
//     required this.color,
//     required this.angleRadians,
//     required this.child,
//   });

//   /// The child widget used as the clock hand and rotated by [angleRadians].
//   final Widget child;

//   /// Hand color.
//   final Color color;

//   /// The angle, in radians, at which the hand is drawn.
//   ///
//   /// This angle is measured from the 12 o'clock position.
//   final double angleRadians;

//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: angleRadians,
//       alignment: Alignment.center,
//       child: child,
//     );
//   }
// }
