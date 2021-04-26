import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  static double screenWidth;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get proportionate height for screen size
double getPropScreenHeight(double heightInput) {
  double screenHeight = SizeConfig.screenHeight;
  // use 812 as it is layout height commonly used by designers
  return (heightInput / 812.0) * screenHeight;
}

// Get proportionate width for screen size
double getPropScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // use 375 as it is layout width commonly used by designers
  return (inputWidth / 375.0) * screenWidth;
}
