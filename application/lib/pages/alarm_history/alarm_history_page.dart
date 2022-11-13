import 'package:flutter/material.dart';

class AlarmHistoryPage extends StatelessWidget {
  const AlarmHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm history'),
      ),
      body: const Center(child: Text('Alarm history page placeholder')),
    );
  }
}
