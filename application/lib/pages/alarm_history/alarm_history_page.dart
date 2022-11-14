import 'package:alarm/alarm.dart';
import 'package:fl_chart/fl_chart.dart';
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
      body: Center(
        child: BlocBuilder<AlarmHistoryCubit, AlarmHistoryState>(
          builder: (context, state) {
            if (state is AlarmHistoryLoaded) {
              // show error message if there are no alarms
              if (state.alarms.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Start creating alarms to see your history!',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final data = BarChartData(
                borderData: FlBorderData(show: false),
                backgroundColor: Colors.blueGrey,
                gridData: FlGridData(
                  show: false,
                ),
                alignment: BarChartAlignment.spaceEvenly,
                barGroups: _alarmToGroupData(state.alarms),
                titlesData: _getTitlesData(state.alarms),
              );

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarChart(data),
              );
            } else if (state is AlarmHistoryLoading) {
              return const CircularProgressIndicator();
            } else if (state is AlarmHistoryError) {
              return Text(
                'Error msg: ${state.errorMessage}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> _alarmToGroupData(List<AlarmModel> alarms) {
    final groups = <BarChartGroupData>[];
    for (int i = 0; i < alarms.length; i++) {
      final alarm = alarms[i];
      final group = BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.zero,
            toY: alarm.secondElapsed?.toDouble() ?? 0,
            color: Colors.white54,
            width: 30,
          ),
        ],
      );
      groups.add(group);
    }

    return groups;
  }

  /// Returns title styling for [BarChart].
  FlTitlesData _getTitlesData(List<AlarmModel> alarms) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final alarm = alarms[value.floor()];

              // TODO: apply date formatting
              return Text(alarm.scheduledFor.toIso8601String());
            },
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 20,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              );
            },
          ),
        ),
        // hide y-axis on top side
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        // hide y-axis on right side
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      );
}
