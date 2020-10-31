import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/Login/login_page.dart';

import 'components/splash_image.dart';
import 'components/splash_sub_title.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash-screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String imagePath = 'assets/icons/guess-who-yellow-logo.png';

  @override
  void initState() {
    new Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, LoginPage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SplashImage(imagePath: imagePath),
            SplashSubTitle(),
            Spacer(),
            Image.asset(
              'assets/icons/nryn.png',
              scale: 5,
            ),
          ],
        ),
      ),
    );
  }
}
