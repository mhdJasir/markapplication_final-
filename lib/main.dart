import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrmarkgrp/sevices/notificationService.dart';
import 'package:hrmarkgrp/user/views/Screens/OnbordingScreen/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  static const Color border = Color(0xFFE9E9E9);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color bgColor = Color(0xFFF6F6F6);
  static const Color appBar = Color(0xFFF6F6F6);
  static Border bord = Border.all(color: border);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mark Group',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

class MyAppBar extends AppBar {
  MyAppBar();
}
