import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:larafit/ui/user_dashboard/user_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper dbHelper = DbHelper();
    dbHelper.openDb();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: buildTheme(),
        home: UserDashboardPage());
  }
}

ThemeData buildTheme() {
  return ThemeData.from(
    colorScheme: ColorScheme(
      primary: Color(0xff92baba),
      primaryVariant: Color(0xff4c8f8d),
      secondary: Color(0xffec6e8b),
      secondaryVariant: Color(0xffe33f5d),
      surface: Colors.white,
      background: Colors.white, //
      error: Color(0xffb00020),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.light,
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
    appBarTheme: AppBarTheme(
      elevation: 5,
      centerTitle: true,
      // brightness: Brightness.dark,
    ),
  );
}
