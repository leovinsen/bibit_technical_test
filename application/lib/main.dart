import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/notification.dart';

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
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AlarmRepository>(
          create: (context) {
            final repository = LocalAlarmRepository(
              database.alarmDao,
              notificationService,
            );

            return repository;
          },
          lazy: false,
        ),
        RepositoryProvider<NotificationService>.value(
            value: notificationService),
      ],
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
