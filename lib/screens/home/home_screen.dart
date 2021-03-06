import 'dart:async';

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/Student.dart';
import 'package:quiz_app/screens/result_page/result_page.dart';
import 'package:quiz_app/size_config.dart';

import '../../constants.dart';
import '../../pin_code_text_field.dart';
import 'components/SubmitButton.dart';
import 'components/blur_image.dart';
import 'components/clear_btn.dart';
import 'components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home-screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seconds = 20;
  int defaultSecond = 20;
  var myController = TextEditingController();
  int score = 0;
  Map<int, String> stringToArrayShuffled = {};
  Map<int, String> deletedLettersList = {};
  Image _image;
  int _index;
  Timer timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var questionState;
  bool showAnswer;
  bool blockActionButton;
  bool showAnswerTileAfterImageLoad = false;
  String regdNo;

  @override
  void initState() {
    students.shuffle();
    _index = 0;
    newQuestion();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void newQuestion() {
    blockActionButton = false;
    showAnswer = false;
    questionState = "going";
    myController.clear();
    stringToArrayShuffled.clear();
    deletedLettersList.clear();

    _image = new Image.network(
      students[_index].imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );

    startTimer();
    shuffleNameLetters(students[_index].name);
  }

  Future<void> eveluateAnswer() async {
    if (myController.text.toLowerCase() ==
        students[_index].name.toLowerCase()) {
      setState(() {
        questionState = "correct";
        score += 200 + seconds;
      });
    } else {
      setState(() {
        questionState = "wrong";
        showAnswer = true;
      });
    }
    await new Future.delayed(const Duration(seconds: 5));

    if (_index + 1 == students.length) {
      Navigator.of(context).pushNamed(
        ResultPage.routeName,
        arguments: {'regdNo': regdNo, 'score': score},
      );
    }
  }

  void startTimer() async {
    _image.image.resolve(new ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          setState(() {
            showAnswerTileAfterImageLoad = true;
          });
          timer = new Timer.periodic(new Duration(seconds: 1), (time) async {
            if (seconds == 0) {
              blockActionButton = true;
              time.cancel();
              await eveluateAnswer();

              seconds = defaultSecond;
              if (_index != students.length - 1)
                setState(() {
                  _index++;
                  newQuestion();
                });
              return;
            }
            setState(() {
              seconds--;
            });
          });
        },
      ),
    );
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
    regdNo = ModalRoute.of(context).settings.arguments as String;
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(secondsLeft: seconds, score: score),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: questionState == "going"
              ? kPrimaryGoingGradientColor
              : (questionState == "correct"
                  ? kPrimaryGradientColor
                  : kPrimaryWrongGradientColor),
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
                    image: _image,
                    sigmaX: questionState == "going" ? 3 : 0,
                    sigmaY: questionState == "going" ? 3 : 0,
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
                  showAnswerTileAfterImageLoad ? buildAnswerBox() : Container(),
                  Spacer(flex: 5),
                  if (!blockActionButton)
                    if (!showAnswer) buildBottomAction(),
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
            SubmitButton(
              press: () async {
                if (myController.text.length == students[_index].name.length) {
                  blockActionButton = true;
                  timer.cancel();
                  await eveluateAnswer();
                  if (_index != students.length - 1) {
                    _index++;
                    seconds = defaultSecond;
                    newQuestion();
                  }
                } else {
                  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: new Text('Complete your friend\'s name!')));
                }
              },
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.03),
            ClearButton(
              press: () {
                if (deletedLettersList.length != 0)
                  setState(() {
                    stringToArrayShuffled.update(
                      deletedLettersList.keys
                          .toList()[deletedLettersList.length - 1],
                      (value) => deletedLettersList.values
                          .toList()[deletedLettersList.length - 1],
                    );

                    deletedLettersList.remove(deletedLettersList.keys
                        .toList()[deletedLettersList.length - 1]);

                    List<String> c = myController.text.split("");
                    c.removeLast();
                    myController.text = c.join();
                  });
              },
            )
          ],
        ),
      ),
    );
  }

  Container buildAnswerBox() {
    if (questionState == "correct")
      return buildEvalutionContainer(
        comment: 'That\'s Correct, You remember\n${students[_index].name}',
        emoji: '💃',
        correctName: students[_index].name,
      );
    if (!showAnswer)
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
    else {
      return buildEvalutionContainer(
        comment: 'Opps! That\'s incorrect',
        emoji: '🥺',
        correctName: students[_index].name,
      );
    }
  }

  Container buildEvalutionContainer(
      {String comment, String emoji, String correctName}) {
    return Container(
      width: getProportionateScreenWidth(250),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: 52,
            ),
          ),
          Text(
            comment,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          if (questionState != "correct")
            Text(
              'Correct Answer',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          if (questionState != "correct")
            Text(
              correctName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 26,
              ),
            ),
          if (questionState == "correct")
            SizedBox(height: SizeConfig.screenHeight * 0.03),
          TweenAnimationBuilder(
            tween: Tween(begin: 5.0, end: 0),
            duration: Duration(seconds: 5),
            builder: (context, value, child) => Text(
              "00:${value.toInt().toString().padLeft(2, '0')}",
              style: TextStyle(color: kPrimaryColor),
            ),
          )
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
        maxLength: students[_index].name.length,
        autofocus: true,
        controller: myController,
        pinBoxRadius: 5,
        pinBoxHeight: getProportionateScreenHeight(30),
        pinBoxWidth: getProportionateScreenWidth(30),
        hasTextBorderColor: kPrimaryColor,
        defaultBorderColor: Colors.transparent,
        pinBoxColor: Colors.black45,
        pinTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
        highlightPinBoxColor: Colors.white12,
        pinTextAnimatedSwitcherTransition:
            ProvidedPinBoxTextAnimation.slideTransition,
        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
        highlightAnimationBeginColor: Colors.black,
        highlightAnimationEndColor: Colors.white12,
      ),
    );
  }

  AutoSizeText buildImageCounter() {
    return AutoSizeText(
      '${_index + 1} / ${students.length}',
      style: TextStyle(
        color: Colors.white70,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
