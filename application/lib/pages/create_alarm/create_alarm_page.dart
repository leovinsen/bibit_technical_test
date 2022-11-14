import 'package:alarm/alarm.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notification/notification.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../blocs/create_alarm/create_alarm_cubit.dart';
import '../../models/time_type.dart';
import '../alarm_history/alarm_history_page.dart';

part 'wrapper.dart';

class CreateAlarmPage extends StatefulWidget {
  const CreateAlarmPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAlarmPage> createState() => _CreateAlarmPageState();
}

class _CreateAlarmPageState extends State<CreateAlarmPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeNotifications();
  }

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
          final timeFormatter = DateFormat('hh:mm:ss');

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
                const SizedBox(height: 20),
                Text(
                  timeFormatter.format(state.selectedTime),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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

  void _initializeNotifications() {
    final alarmRepository = context.read<AlarmRepository>();
    final notificationService = context.read<NotificationService>();

    notificationService.initialize((response) async {
      // only handle notifications with a paylod
      if (response.payload == null) return;

      final alarmId = int.tryParse(response.payload!);

      // terminate if payload is malformed
      if (alarmId == null) return;

      // mark the alarm as opened
      alarmRepository.markOpened(alarmId).then((_) {
        // then redirect user to history page once it's successful
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AlarmHistoryPageWrapper(),
          ),
        );
      });
    });
  }
}
