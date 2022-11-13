import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/create_alarm/create_alarm_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize database
  final database =
      await $FloorAppDatabase.databaseBuilder('alarm_app.db').build();

  runApp(
    // provide AlarmRepository to the whole app, as it will be used in all pages.
    RepositoryProvider(
      create: (_) => LocalAlarmRepository(database.alarmDao),
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
