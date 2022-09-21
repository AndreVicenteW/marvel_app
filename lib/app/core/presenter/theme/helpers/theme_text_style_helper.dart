import 'package:flutter/material.dart';

class ThemeTextStyleHelper {

  static const _fontFamily = 'gilroy';

  static const TextStyle headline1 = TextStyle(
    fontFamily: '$_fontFamily-heavy',
    fontSize: 40,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: '$_fontFamily-heavy',
    fontSize: 20,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: '$_fontFamily-heavy',
    fontSize: 32,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: '$_fontFamily-bold',
    fontSize: 18,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: '$_fontFamily-bold',
    fontSize: 16,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: '$_fontFamily-medium',
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle body2 = TextStyle(
      fontFamily: '$_fontFamily-medium',
      fontSize: 14,
      fontWeight: FontWeight.w300,
  );

  static const TextStyle caption1 = TextStyle(
    fontFamily: '$_fontFamily-regular',
    fontSize: 14,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: '$_fontFamily-regular',
    fontSize: 12,
    fontWeight: FontWeight.w100,
  );
}