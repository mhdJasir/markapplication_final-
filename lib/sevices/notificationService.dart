import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channel_id = "123";

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payoad) async {
      print(payoad);
    });
  }

  void showNotification(String title, String notificationMessage,
      String channelID, String channelName, String channelDesc) async {
    await flutterLocalNotificationsPlugin.show(
        1,
        title,
        notificationMessage,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channelID, channelName, channelDesc,
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        payload: "");
  }

  void cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<bool> wasApplicationLaunchedFromNotification() async {
    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    return notificationAppLaunchDetails.didNotificationLaunchApp;
  }
}
