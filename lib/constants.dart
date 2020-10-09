import 'package:flutter/material.dart';

import 'size_config.dart';

const kPrimaryColor = Color(0xFFE3D659);
const kPrimaryLightColor = Color(0xFF056802);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   color: [Color(0xFFFFA53E), Color(0xFFFF7643)
//   ],
// );
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Color(0xFFE3D659),
    Color(0xFF056802),
  ],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

final inputDecoration = InputDecoration(
  filled: true,
  fillColor: kSecondaryColor.withOpacity(.5),
  contentPadding: EdgeInsets.zero,
  // contentPadding: EdgeInsets.symmetric(
  // vertical: getProportionateScreenWidth(10),
  // ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

// final textDecoration = TextDecoration(

// );

final boxDecoration = BoxDecoration(
  // color: kSecondaryColor.withOpacity(.8),
  color: kPrimaryColor.withOpacity(.5),
  border: Border.all(
    color: kPrimaryColor, // set border color
    width: 3.0,
  ), // set border width
  borderRadius: BorderRadius.circular(10), // make rounded corner of border
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.yellow,
      width: 3,
    ),
  );
}
