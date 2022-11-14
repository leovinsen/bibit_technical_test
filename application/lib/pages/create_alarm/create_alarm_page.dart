import 'package:alarm/alarm.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
                const SizedBox(height: 20),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: state.timeType.index,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: const ['AM', 'PM'],
                  activeBgColors: const [
                    [Colors.amber],
                    [Colors.blueGrey]
                  ],
                  onToggle: (index) {
                    context
                        .read<CreateAlarmCubit>()
                        .setTimeType(TimeType.values[index ?? 0]);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    context.read<CreateAlarmCubit>().createAlarm();
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
