## Usage

Make sure to call `NotificationService.initialize()` once on app start. If you want to perform navigation inside the *"on notification tap"* callback, make sure to use a `BuildContext` instance that has a Navigator on its tree.

For example, in the page that will be opened when user first opens the app.

Uses [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) under the hood.
