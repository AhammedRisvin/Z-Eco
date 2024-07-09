import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

import 'app/utils/prefferences.dart';

// ...

void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.input?.isNotEmpty ?? false) {}
}

class BackgroundNt {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  static final onClickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_notification');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );

    const AndroidNotificationChannel defaultSound = AndroidNotificationChannel(
      'default_channel',
      'Basic Notifications',
      description: 'This channel is used for basic notifications',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('sound'),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(defaultSound);
  }

  // Sound Configure with native sound

  static Future<void> defaultSound(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Basic Notifications',
      importance: Importance.max,
      priority: Priority.high,
      // sound: RawResourceAndroidNotificationSound(
      //   "sound",
      // ),
    );
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        // sound: 'sound',
        );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? "From zoco team",
      message.notification?.body ?? "Notification body",
      details,
      payload: message.data["payload"] ?? "defaultPayload",
    );
  }

  static Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      AppPref.fcmToken = token ?? "";
      return token;
    } catch (e) {
      return "error";
    }
  }

  static Future<void> firebaseInIt() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      defaultSound(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        if (message.notification?.title == "New Order") {}
      },
    );
  }

  static void soundHandler(RemoteMessage message) async {
    String? cId = message.notification?.android?.channelId;
    if (cId == null) {
      onTapNotification();
      return;
    }
    await defaultSound(message);
  }

  static Future<void> onTapNotification() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {}
}
