import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatelessWidget {
  const ClockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock page'),
      ),
      body: const Center(
        child: AnalogClockWidget(),
      ),
    );
  }
}
