import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/time_type.dart';

part 'create_alarm_state.dart';

class CreateAlarmCubit extends Cubit<CreateAlarmState> {
  /// [initialTime] is initial time set for the alarm.
  ///
  /// Sets [TimeType.pm] as default value if [initialTime]
  /// hour value in local time is greater than 12.
  CreateAlarmCubit({
    required DateTime initialTime,
  }) : super(
          CreateAlarmState(
            selectedHour: initialTime.hour,
            selectedMinute: initialTime.minute,
            selectedSecond: initialTime.second,
            timeType: initialTime.hour > 12 ? TimeType.pm : TimeType.am,
          ),
        );

  /// Sets time type to [TimeType.am] or [TimeType.pm].
  void setTimeType(TimeType type) {
    emit(state.copyWith(timeType: type));
  }

  /// Sets the hour value for alarm to be created.
  /// [hour] must be in the range of [0..23].
  void setHour(int hour) {
    if (hour < 0 || hour > 23) {
      // normally we should return validation error, but skipping
      // for simplicity's sake.
      return;
    }
    emit(state.copyWith(selectedHour: hour));
  }

  /// Sets the minute value for alarm to be created.
  /// [minute] must be in the range of [0..60].
  void setMinute(int minute) {
    if (minute < 0 || minute > 60) {
      // normally we should return validation error, but skipping
      // for simplicity's sake.
      return;
    }
    emit(state.copyWith(selectedMinute: minute));
  }

  /// Sets the second value for alarm to be created.
  /// [second] must be in the range of [0..60].
  void setSecond(int second) {
    if (second < 0 || second > 60) {
      // normally we should return validation error, but skipping
      // for simplicity's sake.
      return;
    }
    emit(state.copyWith(selectedSecond: second));
  }

  /// Creates a new alarm notification.
  void createAlarm() {
    // TODO: schedule alarm notification
  }
}
