import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
              buildCloseBtn(),
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

  SizedBox buildCloseBtn() {
    return SizedBox(
      height: 50,
      width: 50,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Icon(Icons.close),
      ),
    );
  }
}
