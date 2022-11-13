import '../persistence/persistence.dart';

/// Defines interface of a repository class responsible for creating,
/// scheduling, and updating alarms.
abstract class AlarmRepository {
  /// Returns all alarms in the database sorted from the most recently created.
  Future<List<AlarmModel>> getAlarms();

  /// Schedules an alarm at given [time].
  ///
  /// Returns [true] when operation is successful or [false] otherwise.
  Future<bool> scheduleAlarm(DateTime time);

  /// Marks an alarm as opened. Will automatically calculate seconds elapsed
  /// from time of creation to current time i.e. [DateTime.now].
  ///
  /// [alarmId] is the unique identifier of the alarm to be updated.
  ///
  /// Returns [true] when operation is successful or [false] otherwise.
  Future<bool> markOpened(int alarmId);
}
