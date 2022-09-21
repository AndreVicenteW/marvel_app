import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';

class ThemeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  final TextAlign? textAlign;

  const ThemeText({
    required this.text,
    this.style = ThemeTextStyleHelper.body1,
    this.color = ThemeColorHelper.primaryDarkColor,
    this.textAlign,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style.copyWith(
        color: color,
      ),
    );
  }
}
