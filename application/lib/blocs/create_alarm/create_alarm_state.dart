part of 'create_alarm_cubit.dart';

/// [CreateAlarmState] contains the currently selected values for
/// hour, minute, and seconds, and whether time is in AM or PM
@immutable
class CreateAlarmState extends Equatable {
  const CreateAlarmState({
    required this.selectedHour,
    required this.selectedMinute,
    required this.selectedSecond,
    required this.timeType,
  });

  /// currently selected hour.
  final int selectedHour;

  /// currently selected minute.
  final int selectedMinute;

  /// currently selected second.
  final int selectedSecond;

  /// whether time is in AM or PM.
  final TimeType timeType;

  /// convenience method for converting [selectedHour], [selectedMinute]
  /// and [selectedSecond] into an instance of [DateTime].
  DateTime get selectedTime {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      selectedHour,
      selectedMinute,
      selectedSecond,
    );
  }

  @override
  List<Object?> get props =>
      [selectedHour, selectedMinute, selectedSecond, timeType];

  CreateAlarmState copyWith({
    int? selectedHour,
    int? selectedMinute,
    int? selectedSecond,
    TimeType? timeType,
  }) {
    return CreateAlarmState(
      selectedHour: selectedHour ?? this.selectedHour,
      selectedMinute: selectedMinute ?? this.selectedMinute,
      selectedSecond: selectedSecond ?? this.selectedSecond,
      timeType: timeType ?? this.timeType,
    );
  }
}
