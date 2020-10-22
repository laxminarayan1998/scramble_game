import 'package:flutter/material.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/screens/splash/splash_screen.dart';
import 'package:quiz_app/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OEC Quiz',
      theme: themeData(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
