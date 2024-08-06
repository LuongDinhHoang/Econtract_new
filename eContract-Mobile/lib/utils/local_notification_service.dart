import 'dart:convert';

import 'package:e_contract/utils/logger.dart';
import 'package:e_contract/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///Bkav Nhungltk: show notification local
class LocalNotificationService{


  LocalNotificationService();

  static const int notificationFirebaseId = 1;

  final _localNotificatiopnService= FlutterLocalNotificationsPlugin();
  Future<void> intialize() async{
    const AndroidInitializationSettings androidInitializationSettings= AndroidInitializationSettings('@mipmap/ic_launcher_round');
    DarwinInitializationSettings iosInitializationSettings= DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings= InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings );
    await _localNotificatiopnService.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails= AndroidNotificationDetails(
    "channel_id", "channel_name",
    channelDescription: "description",
    importance: Importance.max,
    priority: Priority.max,
    playSound: true);
    DarwinNotificationDetails iosInitializationDetail = DarwinNotificationDetails();

    return const NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> showNotification({required int id,
  required String title,
  required String body}) async{
    final details= await _notificationDetails();
    await _localNotificatiopnService.show(id, title, body, details);
}

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
  }

  void onSelectNotification(String? payload) {
    // HanhNTHe: lang nghe tu thong bao
    if (payload != null) {
      Utils.launchAppFromNotification(jsonDecode(payload));
    }
  }

  Future<void> showNotificationFirebase(RemoteMessage message, String isBackground) async {
    var androidDetails = const AndroidNotificationDetails(
      "high_importance_channel",
      "Thông báo hệ thống eContract",
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
    );

    final notificaiton =  message.notification;
    message.data.putIfAbsent("isBackground", () => isBackground);
    Logger.logActivity("showNotificationFirebase notification ($notificaiton)");
    if(notificaiton != null) {
      // Logger.loggerDebug("Bkav DucLQ  nghe khi co thong bao den show notify +++++++++------ $message");
      await _localNotificatiopnService.show(
          notificationFirebaseId,
          "DucLQ show ${notificaiton.title}",
          notificaiton.body,
          NotificationDetails(
            android: androidDetails,
          ), payload: jsonEncode(message.data));

      // HanhNTHe: call api receive notify
      Utils.callApiNotifyReceive(message.data);
    }
  }
}