part of 'alarm_history_page.dart';

/// a simple wrapper page to wrap [AlarmHistoryPage] with
/// an instance of [AlarmHistoryCubit] and its dependencies.
///
/// having a wrapper page also allows us to switch the actual implemenetation
/// of [AlarmHistoryCubit] when testing, e.g. a mocked instance using Mockito.
class AlarmHistoryPageWrapper extends StatelessWidget {
  const AlarmHistoryPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlarmHistoryCubit>(create: (_) {
      final alarmRepository = context.read<AlarmRepository>();
      return AlarmHistoryCubit(alarmRepository);
    });
  }
}
