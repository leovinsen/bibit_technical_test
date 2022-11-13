part of 'alarm_history_cubit.dart';

@immutable
abstract class AlarmHistoryState extends Equatable {
  const AlarmHistoryState();

  @override
  List<Object?> get props => [];
}

/// Initial state i.e. when cubit is first created
class AlarmHistoryInitial extends AlarmHistoryState {
  const AlarmHistoryInitial();
}

/// Loading state i.e. when fetching for data
class AlarmHistoryLoading extends AlarmHistoryState {
  const AlarmHistoryLoading();
}

/// Loaded state i.e. when data is successfully fetched
class AlarmHistoryLoaded extends AlarmHistoryState {
  const AlarmHistoryLoaded(this.alarms);

  /// list of alarms to display.
  final List<AlarmModel> alarms;

  @override
  List<Object?> get props => [alarms];
}

/// Error state i.e. something when wrong when fetching data.
class AlarmHistoryError extends AlarmHistoryState {
  const AlarmHistoryError(this.errorMessage);

  /// a message describing what went wrong.
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
