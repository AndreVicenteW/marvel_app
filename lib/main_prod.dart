import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'main.dart' as main_common;

Future<void> main() async {

  await dotenv.load(fileName: 'env/.env.prod');

  main_common.main();
}