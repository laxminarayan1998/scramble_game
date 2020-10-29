import 'package:flutter/material.dart';
import 'package:quiz_app/screens/Login/login_page.dart';
import 'package:quiz_app/screens/registration_no/registration_screen.dart';
import 'package:quiz_app/screens/result_page/result_page.dart';
import 'package:quiz_app/screens/splash/splash_screen.dart';

import 'screens/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  RegistrationScreen.routeName: (context) => RegistrationScreen(),
  ResultPage.routeName: (context) => ResultPage(),
};
