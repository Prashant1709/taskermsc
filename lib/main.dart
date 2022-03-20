import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskermsc/Screens/home.dart';
import 'package:taskermsc/Screens/login.dart';
import 'package:taskermsc/Screens/register.dart';
import 'package:taskermsc/Screens/title_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: '/',
      routes: {
        '/':(context)=>titlePage(),
        '/login':(context)=>login(),
        '/regist':(context)=>Register(),
        '/home':(context)=>home(),
      },
    );
  }
}
