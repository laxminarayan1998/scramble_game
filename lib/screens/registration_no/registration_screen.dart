import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/default_button.dart';
import 'package:quiz_app/model/Student.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/screens/registration_no/components/users.dart';
import 'package:quiz_app/size_config.dart';

import '../../constants.dart';
import 'components/score_board_card.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "/registration-screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AutoCompleteTextField searchTextField;
  final GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchIdText = new TextEditingController();

  final TextEditingController textEditingController =
      new TextEditingController();

  bool isOk = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: kPrimaryGoingGradientColor),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * .2),
                  buildHeading(context),
                  buildSubtitle(context),
                  SizedBox(height: SizeConfig.screenHeight * .2),
                  buildRegistrationBox(),
                  SizedBox(height: SizeConfig.screenHeight * .2),
                  actionButton(),
                  FutureBuilder(
                    future: getScoreBoardList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return buildScoreBoard();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildScoreBoard() {
    return Container(
      margin: EdgeInsets.only(bottom: getProportionateScreenWidth(32)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: usersByPoints.length,
        itemBuilder: (context, index) {
          usersByPoints.sort((a, b) => b.points.compareTo(a.points));
          return ScoreBoardCard(
            index: index + 1,
            name: usersByPoints[index].name,
            score: usersByPoints[index].points,
          );
        },
      ),
    );
  }

  Widget actionButton() {
    if (isOk)
      return CircularProgressIndicator();
    else
      return SizedBox(
        width: SizeConfig.screenWidth * 0.2,
        child: DefaultButton(
          press: () async {
            if (searchIdText.text != '') {
              if ((users.singleWhere(
                      (element) => element.id == searchIdText.text,
                      orElse: () => null)) !=
                  null) {
                setState(() {
                  isOk = true;
                });
                await getStudentsData();
                setState(() {
                  isOk = false;
                });
                Navigator.pushNamed(
                  context,
                  HomeScreen.routeName,
                  arguments: searchIdText.text,
                );
              } else {
                _scaffoldKey.currentState.showSnackBar(
                  new SnackBar(
                    content:
                        new Text('Please enter correct registration number!'),
                  ),
                );
              }
            } else {
              _scaffoldKey.currentState.showSnackBar(
                new SnackBar(
                  content:
                      new Text('Please enter correct registration number!'),
                ),
              );
            }
          },
          text: 'Play',
        ),
      );
  }

  SizedBox buildRegistrationBox() {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.7,
      child: searchTextField = AutoCompleteTextField<User>(
        controller: searchIdText,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // errorText: isUserNameValidate ? 'Please enter a Username' : null,
          hintText: "e.g, 1701211###",
          hintStyle: TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        key: key,
        clearOnSubmit: false,
        suggestions: users,
        itemFilter: (suggestion, query) {
          return suggestion.id.toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.name.compareTo(b.name);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text(suggestion.name),
            subtitle: Text(suggestion.id.toString()),
          );
          // Row(
          //   children: [Text(suggestion.name), Text(suggestion.id.toString())],
          // );
        },
        itemSubmitted: (data) {
          // setState(() {
          searchTextField.textField.controller.text = data.id;
          // });
        },
      ),
    );
  }

  Text buildSubtitle(BuildContext context) {
    return Text(
      'Play entering by your registration number.',
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white70),
    );
  }

  Text buildHeading(BuildContext context) {
    return Text(
      'Registration Number',
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
    );
  }
}
