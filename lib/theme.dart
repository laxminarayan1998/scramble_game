import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: kPrimaryColor,
    accentColor: Colors.black,
    fontFamily: "Muli",
    colorScheme: ColorScheme.light(
      secondary: kSecondaryColor,
    ),
    backgroundColor: Colors.white,
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
