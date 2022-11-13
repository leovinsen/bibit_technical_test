import 'package:alarm/alarm.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/create_alarm/create_alarm_cubit.dart';
import '../../models/time_type.dart';
import '../alarm_history/alarm_history_page.dart';

part 'wrapper.dart';

class CreateAlarmPage extends StatelessWidget {
  const CreateAlarmPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create alarm page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AlarmHistoryPageWrapper(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: BlocBuilder<CreateAlarmCubit, CreateAlarmState>(
        builder: (context, state) {
          final cubit = context.read<CreateAlarmCubit>();
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnalogClockWidget(
                  onHourUpdated: (hour) {
                    cubit.setHour(hour);
                  },
                  onMinuteUpdated: (minute) {
                    cubit.setMinute(minute);
                  },
                  onSecondUpdated: (second) {
                    cubit.setSecond(second);
                  },
                ),
                const SizedBox(height: 60),
                // TODO: apply date formatting
                Text(state.selectedTime.toIso8601String()),
                const SizedBox(height: 60),
                // TODO: use a good looking switch and support AM/PM
                // currently hardcoded to PM
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    final cubit = context.read<CreateAlarmCubit>();
                    cubit.setTimeType(TimeType.pm);
                    cubit.createAlarm();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
