import 'package:flutter/material.dart';
import 'package:larafit/ui/user_dashboard/user_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: buildTheme(),
        home: UserDashboardPage());
  }
}

ThemeData buildTheme() {
  return ThemeData.from(
    colorScheme: ColorScheme(
      primary: Colors.amber[500],
      primaryVariant: Colors.amber[800],
      secondary: Color(0xFF03DAC5),
      secondaryVariant: Color(0xFF005457),
      surface: Color(0xFF121212),
      background: Color(0xFF121212), //
      error: Color(0xFFCF6679),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.w300, fontSize: 96),
      headline2: TextStyle(fontWeight: FontWeight.w300, fontSize: 60),
      headline3: TextStyle(fontWeight: FontWeight.w400, fontSize: 48),
      headline4: TextStyle(fontWeight: FontWeight.w400, fontSize: 34),
      headline5: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
      headline6: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      subtitle1: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      subtitle2: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      bodyText2: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      button: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
          letterSpacing: 2),
      caption: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
      overline: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
    ),
  ).copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(),
      border: OutlineInputBorder(),
      //alignLabelWithHint: true,
    ),
    buttonColor: Colors.amber[500],
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
    appBarTheme:
        AppBarTheme(color: Colors.transparent, elevation: 0, centerTitle: true),
  );
}
