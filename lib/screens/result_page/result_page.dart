import 'package:flutter/material.dart';
import 'package:quiz_app/screens/registration_no/components/users.dart';
import 'package:quiz_app/screens/registration_no/registration_screen.dart';
import 'package:quiz_app/size_config.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultPage extends StatelessWidget {
  static String routeName = '/result-screen';

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments as Map;
    final String name =
        users.firstWhere((element) => element.id == data['regdNo']).name;

    var url =
        'https://oecgame-4c5b7.firebaseio.com/scoreList/${data['regdNo']}.json';
    try {
      http.patch(
        Uri.parse(url),
        body: json.encode(
          {
            'points': data['score'],
            'isPlayed': true
          },
        ),
      );
    } catch (error) {
      print(error.toString());
    }

    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RegistrationScreen.routeName),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.orange,
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(32),
            ),
            Text(
              'Congratulation!',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              height: getProportionateScreenHeight(26),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(32),
              ),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/icons/9212.png_860.png',
                    height: 100,
                  ),
                  Text(
                    'Hey ${name.substring(0, name.indexOf(" ")).toLowerCase()},\nThank you for Playing.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Score', style: TextStyle(color: Colors.grey)),
                        Text(
                          data['score'].toString(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(32),
            ),
            Text(
              'Note: Still some photos of our friends are not available\nin our database due to unavailable in social media.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
