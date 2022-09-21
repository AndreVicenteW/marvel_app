import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';

class ThemeImage extends StatelessWidget {
  final ThemeImages image;
  final double? width;
  final double? height;
  static const String _imagesAssetsPath =
      './assets/images/';

  const ThemeImage({
    required this.image,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '$_imagesAssetsPath${describeEnum(image)}.png',
      width: width,
      height: height,
    );
  }
}
