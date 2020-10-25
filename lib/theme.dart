import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: kPrimaryColor,
    accentColor: Colors.black,
    fontFamily: "Muli",
    inputDecorationTheme: inputDecorationTheme(),
    colorScheme: ColorScheme.light(
      secondary: kSecondaryColor,
    ),
    backgroundColor: Colors.white,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    
  );
}

// Dark Them
// ThemeData darkThemeData(BuildContext context) {
//   return ThemeData.dark().copyWith(
//     primaryColor: kPrimaryColor,
//     accentColor: kAccentDarkColor,
//     scaffoldBackgroundColor: Color(0xFF0D0C0E),
//     appBarTheme: appBarTheme,
//     colorScheme: ColorScheme.light(
//       secondary: kSecondaryDarkColor,
//       surface: kSurfaceDarkColor,
//     ),
//     backgroundColor: kBackgroundDarkColor,
//     iconTheme: IconThemeData(color: kBodyTextColorDark),
//     accentIconTheme: IconThemeData(color: kAccentIconDarkColor),
//     primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
//     textTheme: GoogleFonts.latoTextTheme().copyWith(
//       bodyText1: TextStyle(color: kBodyTextColorDark),
//       bodyText2: TextStyle(color: kBodyTextColorDark),
//       headline4: TextStyle(color: kTitleTextDarkColor, fontSize: 32),
//       headline1: TextStyle(color: kTitleTextDarkColor, fontSize: 80),
//     ),
//   );
// }

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
