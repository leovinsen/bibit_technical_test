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

  /// Sets the seconds elapsed before an alarm is opened. Use this
  /// when user opens an alarm notification to mark it as opened.
  ///
  /// [alarmId] is the unique identifier of the alarm to be updated, and
  /// [secondsElapsed] is the number of seconds taken before the alarm
  /// is opened.
  ///
  /// Returns [true] when operation is successful or [false] otherwise.
  Future<bool> setSecondsElapsed(int alarmId, int secondsElapsed);
}
