# stream_notifications

A new Flutter plugin.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Getting Started


## Setup

### Android: Register service in the manifest
The plugin uses an Android system service to track notifications.
To allow this service to run the following code should be put inside the Android manifest,
between the `<application></application>` tags.

```xml
 <service android:name="jd.com.stream_notifications.NotificationListener"
          android:label="notifications"
          android:permission="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE">
          <intent-filter>
            <action android:name="android.service.notification.NotificationListenerService" />
          </intent-filter>
 </service>
```

## Use

```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:stream_notifications/stream_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamNotifications _notifications;
  StreamSubscription<LiveNotificationEvent> _subscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(LiveNotificationEvent event) {
    print(event.toString());
  }

  void startListening() {
    _notifications = new StreamNotifications();
    try {
      _subscription = _notifications.notificationStream.listen(onData);
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
      ),
    );
  }
}
```

