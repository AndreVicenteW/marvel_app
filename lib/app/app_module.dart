import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_dio_client_service.dart';
import 'package:marvel_app/app/core/services/local_database_service/local_database_service.dart';
import 'package:marvel_app/app/modules/home/data/dao/comics_dao.dart';

import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {

  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton<Dio>((i) => Dio()),
    Bind.lazySingleton((i) => FirebaseAuth.instance),
    Bind.lazySingleton<HttpClientService>((i) => HttpDioClientService.withDefaultParams(i())),
    Bind.lazySingleton<LocalDatabaseService>((i) => ComicsDao())
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}