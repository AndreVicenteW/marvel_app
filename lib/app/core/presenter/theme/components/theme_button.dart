import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';

class ThemeButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color color;
  final bool loading;

  ThemeButton(
      {required this.text,
      this.onPressed,
      this.color = ThemeColorHelper.primaryRedColor,
      this.loading = false,
      Key? key})
      : super(key: key);

  /* Loader */
  final _loadingWidget = Center(
    child: SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation(ThemeColorHelper.primaryWhiteColor),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: color, padding: EdgeInsets.symmetric(vertical: 10)),
      child: loading
          ? _loadingWidget
          : ThemeText(
              text: text.toUpperCase(),
              color: ThemeColorHelper.primaryWhiteColor,
              style: ThemeTextStyleHelper.subtitle1,
            ),
    );
  }
}
