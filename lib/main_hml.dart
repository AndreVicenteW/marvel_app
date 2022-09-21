import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'main.dart' as main_common;

Future<void> main() async {
  FlavorConfig(
    name: 'hml',
    color: Colors.red,
    location: BannerLocation.topStart,
  );

  await dotenv.load(fileName: 'env/.env.hml');

  main_common.main();
}