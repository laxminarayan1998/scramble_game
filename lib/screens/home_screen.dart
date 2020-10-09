import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/Student.dart';
import 'package:quiz_app/pin_code_fields.dart';
import 'package:quiz_app/size_config.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../constants.dart';
import 'components/blur_image.dart';
import 'components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seconds = 5;
  var myController = TextEditingController();
  Map<int, String> stringToArrayShuffled = {};

  bool _isVisible = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    new Timer.periodic(new Duration(seconds: 1), (time) {
      if (seconds == 0) {
        time.cancel();
        return;
      }
      setState(() {
        seconds--;
      });
    });
    shuffleNameLetters(students[0].name);
    super.initState();
  }

  // void shuffleNameLetters(String name) {
  //   stringToArray = students[0].name.split("");
  //   stringToArray.shuffle();
  //   if (stringToArray.join() == students[0].name) {
  //     stringToArray.shuffle();
  //   }
  // }

  void shuffleNameLetters(String name) {
    Map<int, String> stringToArray = {};
    List charList = name.split("");
    for (int i = 0; i < name.length; i++) {
      stringToArray.putIfAbsent(i, () => charList[i]);
    }
    var keys = stringToArray.keys.toList()..shuffle();
    for (var k in keys) {
      stringToArrayShuffled.putIfAbsent(k, () => stringToArray[k]);
    }
    print(stringToArrayShuffled);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        secondsLeft: seconds,
        score: 320,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: kPrimaryGradientColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                BlurImage(
                  url: students[0].imageUrl,
                  sigmaX: 0,
                  sigmaY: 0,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                buildImageCounter(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                buildBlankBox(context),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                Container(
                  width: getProportionateScreenWidth(350),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // ...List.generate(
                      //   students[0].name.length,
                      //   (index) => GestureDetector(
                      //       onTap: () {
                      //         shuffleNameLetters(students[index].name);
                      //       },
                      //       child: Text("data")),
                      // )
                      ...List.generate(
                          stringToArrayShuffled.values.toList().length,
                          (index) {
                        return buildAnswerInput(
                          char: stringToArrayShuffled.values.toList()[index],
                          press: () {
                            print(stringToArrayShuffled.values.toList()[index]);
                            print(stringToArrayShuffled.keys.toList()[index]);
                            setState(() {
                              stringToArrayShuffled.update(
                                  stringToArrayShuffled.keys.toList()[index],
                                  (value) => "");
                            });
                          },
                        );
                        // Text(
                        //   students[0].name[index].toUpperCase(),
                        // );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAnswerInput({String char, GestureTapCallback press}) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: SizeConfig.screenWidth <= 768
            ? (SizeConfig.screenWidth <= 425
                ? getProportionateScreenWidth(35)
                : getProportionateScreenWidth(20))
            : getProportionateScreenWidth(15),
        height: SizeConfig.screenWidth <= 768
            ? (SizeConfig.screenWidth <= 425
                ? getProportionateScreenWidth(35)
                : getProportionateScreenWidth(20))
            : getProportionateScreenWidth(15),
        decoration:  char == "" ? null : boxDecoration,
        child: Center(
          child: Text(
            char.toUpperCase(),
            style: TextStyle(
                fontSize: 18, color: Colors.brown, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
            // decoration: inputDecoration,
            // onChanged: (value) {},
          ),
        ),
      ),
    );
  }

  Container buildBlankBox(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth >= 768
          ? getProportionateScreenWidth(250)
          : getProportionateScreenWidth(350),
      child: PinCodeTextField(
        controller: myController,
        autoFocus: true,
        appContext: context,
        backgroundColor: Colors.transparent,
        mainAxisAlignment: MainAxisAlignment.center,
        // enableActiveFill: true,
        pinTheme: PinTheme.defaults(
          shape: PinCodeFieldShape.box,
          // inactiveColor: Colors.transparent,
          fieldHeight: SizeConfig.screenWidth >= 768
              ? getProportionateScreenHeight(30)
              : getProportionateScreenHeight(25),
          fieldWidth: SizeConfig.screenWidth >= 768
              ? getProportionateScreenHeight(30)
              : getProportionateScreenHeight(25),
          borderRadius: SizeConfig.screenWidth >= 768
              ? BorderRadius.circular(10)
              : BorderRadius.circular(5),
          activeColor: kPrimaryColor,
          inactiveColor: Colors.transparent,
          selectedColor: kPrimaryColor,
        ),
        length: students[0].name.length,
        onChanged: null,
      ),
    );
  }

  // void hio(String myCon) {
  //   String x = "aaabcd";
  //   List<String> c = x.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
  //   c.removeLast(); // ['a', 'a', 'a', 'b', 'c']
  //   print(c.join()); //aaabc
  // }

  // myController.text += char.toUpperCase();

  Text buildImageCounter() {
    return Text(
      '1/20',
      style: TextStyle(
          color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w800),
    );
  }
}
