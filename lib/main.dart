import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:larafit/bindings/dashboard_bindings.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:larafit/routes/app_pages.dart';
import 'package:larafit/routes/app_routes.dart';
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
      initialRoute: Routes.DASHBOARD,
      initialBinding: DashboardBinding(),
      getPages: AppPages.routes,
    );
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
      headline1:
          GoogleFonts.openSans(fontWeight: FontWeight.w300, fontSize: 96),
      headline2:
          GoogleFonts.openSans(fontWeight: FontWeight.w300, fontSize: 60),
      headline3:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 48),
      headline4:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 34),
      headline5:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 24),
      headline6:
          GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600),
      subtitle1:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 16),
      subtitle2:
          GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 14),
      bodyText1:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 16),
      bodyText2:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 14),
      button: GoogleFonts.openSans(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
          letterSpacing: 2),
      caption: GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 12),
      overline: GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 10),
    ),
  ).copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(),
      border: OutlineInputBorder(),
      //alignLabelWithHint: true,
    ),
    buttonColor: Color(0xffec6e8b),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xffec6e8b),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 5,
      centerTitle: true,
      // brightness: Brightness.dark,
    ),
  );
}
