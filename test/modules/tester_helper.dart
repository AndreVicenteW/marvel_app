import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvel_app/app/app_module.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';
import 'package:marvel_app/app/core/services/local_database_service/local_database_service.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/presenter/pages/home/home_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

class TesterHelper {

  static Future<void> init() async {

    dotenv.testLoad(fileInput: File('env/.env.dev').readAsStringSync());

    initModule(AppModule(), replaceBinds: [
      Bind.instance<HttpClientService>(MockAppHttpClient()),
      Bind.instance<LocalDatabaseService>(MockLocalDatabaseService()),
    ]);
  }

  static Widget buildTestableWidget(Widget widget) {

    return MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    );
  }

  static void setPushReplacementNamedMock({required Widget page}) {
    final navigate = ModularNavigateMock();
    Modular.navigatorDelegate = navigate;

    when(() => navigate.pushReplacementNamed(any())).thenAnswer(
          (_) async => page,
    );
  }

  static Future createMockDioResponse(
      String json,
      int httpStatus, {
        RequestOptions? requestOptions,
        bool decode = true
      }) async {
    return Response(
      data: decode ? jsonDecode(json) : json,
      statusCode: httpStatus,
      requestOptions: requestOptions ?? RequestOptions(path: ':path'),
    );
  }
}

class MockAppHttpClient extends Mock implements HttpClientService {}
class MockLocalDatabaseService extends Mock implements LocalDatabaseService<ComicDto> {}
