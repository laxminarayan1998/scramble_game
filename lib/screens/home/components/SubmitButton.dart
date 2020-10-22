import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    this.press,
  }) : super(key: key);

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: getProportionateScreenWidth(250),
        height: getProportionateScreenWidth(30),
        decoration: submitBoxDecoration,
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
    );
  }
}
