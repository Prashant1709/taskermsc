import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskermsc/Screens/Profile%20Page/profile2.dart';
import 'package:taskermsc/Screens/calendar.dart';
import 'package:taskermsc/Screens/login.dart';
import 'package:taskermsc/Screens/home.dart';
import 'package:taskermsc/Screens/register.dart';
import 'package:taskermsc/Screens/title_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => titlePage(),
        '/login': (context) => login(),
        '/regist': (context) => Register(),
        '/home': (context) => home(),
        '/calendar': (context) => calendar(),
        '/profile2': (context) => Profile2(),
        '/calendar':(context)=>calendar(),
      },
    );
  }
}
