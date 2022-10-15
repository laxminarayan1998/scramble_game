import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/registration_no/registration_screen.dart';

import '../../../size_config.dart';

class CustomAppBar extends PreferredSize {
  final int secondsLeft;
  final int score;

  CustomAppBar({
    @required this.secondsLeft,
    @required this.score,
  });

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: Padding(
          padding: SizeConfig.screenWidth > 991
              ? EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(80),
                )
              : EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCloseBtn(context),
              // Spacer(),
              buildTimer(context, secondsLeft),
              // Spacer(),
              buildScoreBorder()
            ],
          ),
        ),
      ),
    );
  }

  Container buildScoreBorder() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
        vertical: getProportionateScreenHeight(5),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3),
        //   ),
        // ],
      ),
      child: Text(
        "Score: $score",
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildTimer(BuildContext context, int secondsLeft) {
    return Container(
      height: getProportionateScreenWidth(30),
      width: getProportionateScreenWidth(30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF696969).withOpacity(0.5),
          width: 2.4,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(60),
        ),
      ),
      child: Center(
        child: AutoSizeText(
          secondsLeft.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  SizedBox buildCloseBtn(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextButton(
        // padding: EdgeInsets.zero,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () async {
          await showAlertDialog(context);
        },
        child: Icon(Icons.close),
      ),
    );
  }
}

showAlertDialog(BuildContext context) async {
  Widget okButton = TextButton(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(
          color: Color(0xFFFF3535),
        ),
      ),
    ),
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, RegistrationScreen.routeName);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Center(
      child: Text(
        "💔",
        style: TextStyle(fontSize: 49),
      ),
    ),
    content: Container(
      height: 100,
      child: Column(
        children: [
          Text(
            "Are you sure you want to leave?",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Color(0xFFDEDEDE),
                      ),
                    ),
                  ),
                  // color: ,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(18.0),
                  // ),
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Color(0xFFFF3535),
                      ),
                    ),
                  ),
                  // color: Color(0xFFFF3535),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(18.0),
                  // ),
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  },
                )
              ])
        ],
      ),
    ),
    // actions: [
    //   okButton,
    // ],
  );

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
