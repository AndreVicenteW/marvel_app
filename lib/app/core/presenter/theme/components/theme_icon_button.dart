import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';

class ThemeIconButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color color;
  final LinearGradient? gradientColor;
  final IconData icon;

  const ThemeIconButton({
    required this.text,
    this.onPressed,
    this.color = ThemeColorHelper.primaryBlueColor,
    this.gradientColor,
    this.icon = Icons.lock_outline,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _borderRadius = 10.0;

    return Container(
      decoration: BoxDecoration(
          color: color,
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.8),
              blurRadius: 8,
              offset: Offset(1.50, 2.50)
            )
          ]),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderRadius))),
          child: Column(
            children: [
              Icon(icon),
              SizedBox(
                height: 8,
              ),
              ThemeText(
                text: text,
                color: ThemeColorHelper.primaryWhiteColor,
                style: ThemeTextStyleHelper.subtitle1,
              ),
            ],
          )),
    );
  }
}
