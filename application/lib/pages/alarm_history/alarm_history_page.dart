import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/alarm_history/alarm_history_cubit.dart';

part 'wrapper.dart';

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
