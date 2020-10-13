import 'package:flutter/material.dart';

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

const kPrimaryGoingGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Color(0xFFE3D659),
    Color(0xFF685A02),
  ],
);

const kPrimaryWrongGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[
    Color(0xFFE3D659),
    Color(0xFF680202),
  ],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

final inputDecoration = InputDecoration(
  filled: true,
  fillColor: kSecondaryColor.withOpacity(.5),
  contentPadding: EdgeInsets.zero,
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

final boxDecoration = BoxDecoration(
  color: kPrimaryColor,
  border: Border.all(
    color: Colors.black87.withOpacity(.4),
    width: 3.0,
  ),
  borderRadius: BorderRadius.circular(10),
);

final submitBoxDecoration = BoxDecoration(
  color: Color(0xFFB71616),
  border: Border.all(
    color: Colors.white54,
    width: 1.5,
  ),
  borderRadius: BorderRadius.circular(5),
);

final clearBoxDecoration = BoxDecoration(
  color: Colors.blue,
  border: Border.all(
    color: Colors.white54,
    width: 1.5,
  ),
  borderRadius: BorderRadius.circular(5),
);

final emptyBoxDecoration = BoxDecoration(
  color: Colors.black87.withOpacity(.4),
  borderRadius: BorderRadius.circular(10),
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
