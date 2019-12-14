import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class StreamNotifications {

  static const EventChannel _notificationEventChannel =
  EventChannel('notifications.eventChannel');

  Stream<LiveNotificationEvent> _notificationStream;

  Stream<LiveNotificationEvent> get notificationStream {
    if (Platform.isAndroid) {
      if (_notificationStream == null) {
        _notificationStream = _notificationEventChannel
            .receiveBroadcastStream()
            .map((event) => _notificationEvent(event));
      }
      return _notificationStream;
    }
    throw NotificationException(
        'LiveNotificatoin is only aveliable on Android!');
  }

}


class NotificationException implements Exception {
  String _cause;

  NotificationException(this._cause);

  @override
  String toString() {
    return _cause;
  }
}

LiveNotificationEvent _notificationEvent(dynamic data) {
  return new LiveNotificationEvent.fromMap(data);
}

class LiveNotificationEvent {
  String packageMessage;
  String packageName;
  DateTime timeStamp;

  LiveNotificationEvent({this.packageName, this.packageMessage, this.timeStamp});

  factory LiveNotificationEvent.fromMap(Map<dynamic, dynamic> map) {
    DateTime time = DateTime.now();
    String name = map['packageName'];
    String message = map['packageMessage'];

    return LiveNotificationEvent(packageName: name, packageMessage: message, timeStamp: time);
  }

  @override
  String toString() {
    return "Notification Event \n Package Name: $packageName \n - Timestamp: $timeStamp \n - Package Message: $packageMessage";
  }
}

