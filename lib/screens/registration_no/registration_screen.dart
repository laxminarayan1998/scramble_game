import 'package:flutter/material.dart';
import 'package:quiz_app/default_button.dart';
import 'package:quiz_app/model/Student.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/size_config.dart';

import '../../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "/registration-screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController textEditingController =
      new TextEditingController();

  bool isOk = false;

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      // _formKey.currentState.save();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          // size: 40,
          color: Colors.white,
        ),
        // title: Text(
        //   'Enter registration number',
        //   style: TextStyle(color: Colors.white, fontSize: 25),
        // ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(gradient: kPrimaryGoingGradientColor),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * .2),
                Text(
                  'Registration Number',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'Play entering by your registration number.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.white70),
                ),
                SizedBox(height: SizeConfig.screenHeight * .2),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.7,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "e.g, 1701211###",
                        hintStyle: TextStyle(fontSize: 14),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value.length < 3)
                          return 'Wrong registration number';
                        else
                          return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * .2),
                if (isOk)
                  CircularProgressIndicator()
                else
                  SizedBox(
                    width: SizeConfig.screenWidth * 0.2,
                    child: DefaultButton(
                      press: () async {
                        setState(() {
                          isOk = true;
                        });
                        _validateInputs();
                        await suggestions();
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                      text: 'Play',
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
