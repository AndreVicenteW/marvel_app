import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';

class ThemeGradientHelper {
  static const LinearGradient gradientBlue = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ThemeColorHelper.primaryBlueColor,
      ThemeColorHelper.secondaryBlueColor,
    ],
  );

  static const LinearGradient gradientGreen = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ThemeColorHelper.primaryGreenColor,
      ThemeColorHelper.secondaryGreenColor,
    ],
  );

  static const LinearGradient gradientPurple = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ThemeColorHelper.primaryPurpleColor,
      ThemeColorHelper.secondaryPurpleColor,
    ],
  );
}