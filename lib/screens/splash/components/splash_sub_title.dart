import 'package:flutter/material.dart';

class SplashSubTitle extends StatelessWidget {
  const SplashSubTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Inspired by ',
        style: TextStyle(
          fontWeight: FontWeight.w100,
          color: Colors.white,
          fontFamily: 'Muli',
        ),
        children: [
          TextSpan(
            text: 'Flipkart Guess What',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontFamily: 'Muli',
            ),
          ),
        ],
      ),
    );
  }
}
