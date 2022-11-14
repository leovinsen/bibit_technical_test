See the following [YouTube playlist](https://www.youtube.com/playlist?list=PLuIivo2SM9QZ-H_6auerE4ObEv6zlHTgj) for quick explanation of the app.

## Features

There are two pages:
- Create Alarm Page (initial page)
- Alarm History Page

On *Create Alarm Page*, you are able to set an alarm by interacting with an analog clock widget. 

On *Alarm History Page*, users can see a history of last 5 alarms that have been created. Only opened alarms will be shown. 

For each page, there is a `wrapper.dart` class associated with it, which simply wraps the actual UI with a `BlocProvider` instance.

## State Management

BLoC is chosen as the state management library. Each page will have its BLoC/Cubit counterpart named after it. 

For example, `CreateAlarmCubit` for `CreateAlarmPage` and `AlarmHistoryCubit` for `AlarmHistoryPage`.

