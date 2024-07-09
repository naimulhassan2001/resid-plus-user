import 'dart:convert';

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resid_plus_user/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class PushNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
///==================Notification permission ====================
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: true,
        sound: true,
        criticalAlert: true);



    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permission Granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Permission provisional");
    } else {
      print("Permission deinai");
    }

    if (Platform.isIOS || Platform.isAndroid) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );}

  }
  ///=================Local Notification============================

  foreGroundMessage()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,sound: true,badge: true);

  }
  Future<void> initLocalNotification({RemoteMessage? message}) async {
    var androidInitializationSettings =
    const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});

    if(message != null) {
      showNotification(message) ;

    }



  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification ? naotification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      initLocalNotification(message: message);
    });
  }
  ///======================Show notification ================
  Future<void> showNotification(RemoteMessage message) async {

    String id = message.notification?.android?.channelId ?? "0" ;
    print("===================================> ${message.notification?.android?.channelId ?? "0"}") ;

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        id,
        "High Importance Notification",
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(channel.id, channel.name,
        channelDescription: "your channel Description",
        importance: Importance.high,
        priority: Priority.high,
        ticker: "ticker");

    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          int.parse(id),
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    }
    );
  }

  Future<String> getDeviceFcmToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  onTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      print(event.toString());
    });
  }
///---------------------- sent token to backend ---------------------->
  Future<void> sendToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    String tokeName = "Bearer";

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(SharedPreferenceHelper.accessTokenKey) ?? "";

    print("push notification token: $fcmToken");
    print("Auth token: $token");

    Uri url = Uri.parse("https://resid-plus.com/api/users/fcm-token");

    // Prepare the request body
    Map<String, String> body = {
      "fcmToken": fcmToken.toString()
    };
    // Prepare the request headers
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "$tokeName $token",
    };
    // Convert the body to a JSON string
    String requestBody = jsonEncode(body);

    // Make the POST request
    http.Response response = await http.post(
      url,
      headers: headers,
      body: requestBody,
    );

    // Check the response
    if (response.statusCode == 200) {
      // Request successful, do something
      print("FCM token sent successfully.");
    } else {
      // Request failed, handle the error
      print("Failed to send FCM token. Error: ${response.statusCode}");
    }
  }
}