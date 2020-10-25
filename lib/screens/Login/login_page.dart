import 'package:flutter/material.dart';
import 'package:quiz_app/default_button.dart';
import 'package:quiz_app/screens/registration_no/registration_screen.dart';

import '../../constants.dart';
import '../../size_config.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login_page";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        // height: 100,
        decoration: BoxDecoration(gradient: kPrimaryGoingGradientColor),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                Text(
                  "Instructions",
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth > 425
                        ? getProportionateScreenWidth(10)
                        : getProportionateScreenWidth(26) / 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      InstructionCard(
                        icon: Icons.photo,
                        title: 'Guess your friend image',
                        description:
                            'Use the given characters to form the\nword that represents the image.',
                        textDirection: TextDirection.ltr,
                      ),
                      InstructionCard(
                        icon: Icons.assignment,
                        title: 'Give it your best shot',
                        description:
                            'Submit the answer you think is correct in 20 scond;\nthere\'s no penalty for incorrect answers.',
                        textDirection: TextDirection.rtl,
                      ),
                      InstructionCard(
                        icon: Icons.alarm_add,
                        title: 'Answer qickly for time bonus.',
                        description:
                            'Submit the answer as fast as you can to earn a\nhigher time bonus for every correct answer,\nplayers with heighestscores win the game.',
                        textDirection: TextDirection.ltr,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      // Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(30),
                            vertical: getProportionateScreenHeight(10)),
                        child: DefaultButton(
                          text: 'Continue',
                          press: () {
                            Navigator.pushNamed(context, RegistrationScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                )
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InstructionCard extends StatelessWidget {
  const InstructionCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.icon,
    @required this.textDirection,
  }) : super(key: key);

  final String title, description;
  final IconData icon;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20)),
      // padding: EdgeInsets.only(
      //     bottom: SizeConfig.screenWidth > 425
      //         ? getProportionateScreenHeight(30)
      //         : getProportionateScreenHeight(100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        textDirection: textDirection,
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
            size: SizeConfig.screenWidth > 425
                ? getProportionateScreenWidth(26)
                : getProportionateScreenWidth(56),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth > 425
                      ? getProportionateScreenWidth(6)
                      : getProportionateScreenWidth(12),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: SizeConfig.screenWidth > 425
                      ? getProportionateScreenWidth(6)
                      : getProportionateScreenWidth(10),
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
