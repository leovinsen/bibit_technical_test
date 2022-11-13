part of 'create_alarm_page.dart';

/// a simple wrapper page to wrap [CreateAlarmPage] with
/// an instance of [CreateAlarmCubit] and its dependencies.
///
/// having a wrapper page also allows us to switch the actual implemenetation
/// of [CreateAlarmCubit] when testing, e.g. a mocked instance using Mockito.
class CreateAlarmPageWrapper extends StatelessWidget {
  const CreateAlarmPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateAlarmCubit>(
      create: (context) {
        final initialTime = DateTime.now();

        return CreateAlarmCubit(
          initialTime: initialTime,
          alarmRepository: context.read<AlarmRepository>(),
        );
      },
      child: const CreateAlarmPage(),
    );
  }
}
