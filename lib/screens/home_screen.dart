import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/Student.dart';
import 'package:quiz_app/pin_code_fields.dart';
import 'package:quiz_app/size_config.dart';

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
  Map<int, String> deletedLettersList = {};

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
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Spacer(),
                  BlurImage(
                    url: students[0].imageUrl,
                    sigmaX: 0,
                    sigmaY: 0,
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  buildImageCounter(),
                  Spacer(),
                  buildBlankBox(context),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Spacer(),
                  buildAnswerBox(),
                  Spacer(
                    flex: 5,
                  ),
                  buildBottomAction(),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildBottomAction() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: SizeConfig.screenWidth >= 1440
            ? 80
            : getProportionateScreenWidth(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: getProportionateScreenWidth(250),
                height: getProportionateScreenWidth(30),
                decoration: skipBoxDecoration,
                child: Center(
                  child: FittedBox(
                    child: Text(
                      'Submit'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.03),
            InkWell(
              onTap: () {
                if (deletedLettersList.length != 0)
                  setState(() {
                    stringToArrayShuffled.update(
                        deletedLettersList.keys
                            .toList()[deletedLettersList.length - 1],
                        (value) => deletedLettersList.values
                            .toList()[deletedLettersList.length - 1]);

                    deletedLettersList.remove(deletedLettersList.keys
                        .toList()[deletedLettersList.length - 1]);

                    List<String> c = myController.text.split("");
                    c.removeLast();
                    myController.text = c.join();
                  });
              },
              child: Container(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenWidth(30),
                decoration: clearBoxDecoration,
                child: Center(
                  child: FittedBox(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildAnswerBox() {
    return Container(
      width: getProportionateScreenWidth(250),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          ...List.generate(stringToArrayShuffled.values.toList().length,
              (index) {
            return buildAnswerInput(
              char: stringToArrayShuffled.values.toList()[index],
              press: () {
                setState(() {
                  myController.text += stringToArrayShuffled.values
                      .toList()[index]
                      .toUpperCase();
                  deletedLettersList.putIfAbsent(
                    stringToArrayShuffled.keys.toList()[index],
                    () => stringToArrayShuffled.values.toList()[index],
                  );
                  stringToArrayShuffled.update(
                    stringToArrayShuffled.keys.toList()[index],
                    (value) => "",
                  );
                });
              },
            );
          })
        ],
      ),
    );
  }

  GestureDetector buildAnswerInput({String char, GestureTapCallback press}) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: getProportionateScreenWidth(50),
        height: getProportionateScreenHeight(35),
        decoration: char == "" ? emptyBoxDecoration : boxDecoration,
        child: Center(
          child: AutoSizeText(
            char.toUpperCase(),
            style: TextStyle(
              fontSize: 24,
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Container buildBlankBox(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        controller: myController,
        autoFocus: true,
        appContext: context,
        textStyle: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
        backgroundColor: Colors.transparent,
        mainAxisAlignment: MainAxisAlignment.center,
        // enableActiveFill: true,
        pinTheme: PinTheme.defaults(
          shape: PinCodeFieldShape.box,
          fieldHeight: getProportionateScreenHeight(30),
          fieldWidth: getProportionateScreenWidth(30),
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

  AutoSizeText buildImageCounter() {
    return AutoSizeText(
      '1/20',
      style: TextStyle(
        color: Colors.white60,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
