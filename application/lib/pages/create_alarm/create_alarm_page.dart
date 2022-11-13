import 'package:analog_clock/analog_clock.dart';
import 'package:bibit_technical_test/blocs/cubit/create_alarm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                // TODO: add switch for AM/PM
              ],
            ),
          );
        },
      ),
    );
  }
}
