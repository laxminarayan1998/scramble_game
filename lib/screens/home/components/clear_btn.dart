import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
class ClearButton extends StatelessWidget {
  const ClearButton({
    Key key,
    this.press,
  }) : super(key: key);
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: getProportionateScreenWidth(30),
        height: getProportionateScreenWidth(30),
        decoration: clearBoxDecoration,
        child: Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
