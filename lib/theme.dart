import 'package:flutter/material.dart';
import 'package:skivvy_app/store/size_config.dart';

const skivvyBaseColor = Color(0xFF7C4DFF);
const skivvyBaseLightColor = Color(0xFFD1C4E9);
const skivvyBaseGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(255, 255, 255, 1.0),
      Color.fromRGBO(209, 196, 233, 1.0),
      Color.fromRGBO(179, 157, 219, 1.0),
      Color.fromRGBO(126, 87, 194, 1.0)
    ]);

const skivvySecondaryColor = Color(0xFFFFAB00);
const skivvyAccentColor = Color(0xFF673AB7);
const textColorLight = Color(0xFF979797);
const textColor = Color(0xFF616161);

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    accentColor: skivvyAccentColor,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: textColor),
    bodyText2: TextStyle(color: textColorLight),
  );
}

final headingStyle = TextStyle(
  fontSize: getPropScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.deepPurpleAccent,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: textColorLight),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
