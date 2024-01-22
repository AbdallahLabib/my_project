//this file will br responsible on all our push notification logic

// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_maps/core/constants/paths.dart';
import 'package:flutter_maps/main.dart';

Future<void> handleBackgroundMessege(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payLoaed: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Invoked inside main method
  Future<void> initNotification() async {
    //this method for requested permessions from the user
    //in android it will return a value indicating wether the app notifications are enabeled
    //or disabled by the operating system
    await _firebaseMessaging.requestPermission();
    //get firebase cloud messeging token, this token is identifier for our device in our app
    //we will use it later on for sending notifications to this specific device
    final fCMToken = await _firebaseMessaging.getToken();

    print("token: $fCMToken");
    // we will add the code that allows us to recieve a notification in background and in the
    // terminated case

    initPushNotification();
    initLocalNotifications();
  }

  // Configuration of the 3 states
  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    // FirebaseMessaging.instance.getInitialMessage().then(handleMessege);

    // Terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessege(initialMessage);
    }

    // Background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessege);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessege);

    // Foreground state
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) return;
        _localNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _androidChannel.id,
                _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: "@mipmap/ic_launcher",
              ),
            ),
            payload: jsonEncode(message.toMap()));
      },
    );
  }

  // Handles Foreground notification
  // 1. For Android
  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "high_importance_Notifactions",
    description: "this channel is used for important notidication",
    importance: Importance.defaultImportance,
  );

  // 2. Local notification
  final _localNotification = FlutterLocalNotificationsPlugin();

  // 3. Local notification configuration
  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));

        _handleMessege(message);
      },
    );

    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  /// Opens the route inside the notification
  void _handleMessege(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.pushNamed(notificationScreen, arguments: message);
  }
}
