import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/notification.dart';

import 'pages/alarm_history/alarm_history_page.dart';
import 'pages/create_alarm/create_alarm_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize database
  final database =
      await $FloorAppDatabase.databaseBuilder('alarm_app.db').build();

  // create notification service -- it will be initalized in MyApp once app is running.
  final notificationService =
      NotificationService(FlutterLocalNotificationsPlugin());

  runApp(
    // provide AlarmRepository to the whole app, as it will be used in all pages.
    RepositoryProvider<AlarmRepository>(
      create: (context) {
        final repository = LocalAlarmRepository(
          database.alarmDao,
          notificationService,
        );

        notificationService.initialize((response) async {
          // only handle notifications with a paylod
          if (response.payload == null) return;

          final alarmId = int.tryParse(response.payload!);

          // terminate if payload is malformed
          if (alarmId == null) return;

          // mark the alarm as opened
          repository.markOpened(alarmId).then((_) {
            // then redirect user to history page once it's successful
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AlarmHistoryPageWrapper(),
              ),
            );
          });
        });

        return repository;
      },
      lazy: false,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bibit Technical Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateAlarmPageWrapper(),
    );
  }
}
