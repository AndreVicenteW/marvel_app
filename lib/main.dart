import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/presenter/theme/helpers/theme_color_helper.dart';

import 'app/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCdYxDDS6HVEybat_OdN-rUv9wcmzHEgrU',
        appId: '1:753383791517:web:80cb9fb3222d7052806d74',
        messagingSenderId: '753383791517',
        projectId: 'marvelapp-9c80d',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: MaterialApp.router(
        title: 'Marvel app',
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        theme: ThemeData(
          primaryColor: ThemeColorHelper.primaryRedColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ThemeColorHelper.primaryRedColor,
            secondary: Colors.black,
          ),
        ),
      ),
    );
  }
}
