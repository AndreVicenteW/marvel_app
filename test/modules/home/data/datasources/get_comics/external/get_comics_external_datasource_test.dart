import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/external/get_comics_external_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/get_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

void main() {
  late HttpClientService _httpService;
  late GetComicsDataSource _getComicsExternalDataSource;

  setUpAll(() async {
    await TesterHelper.init();
    _httpService = Modular.get();
    _getComicsExternalDataSource = GetComicsExternalDataSourceImp(_httpService);
  });

  group('Get comics external data source test', () {
    test('Should return list of CharacterEntity when success', () async {
      var _search = '';

      when(() => _httpService.get(
            any(),
            queryParameters: {
              'limit': 10,
              'offset': 0,
              'format': 'comic',
              'noVariants': true,
              'titleStartsWith': _search
            },
          )).thenAnswer(
        (_) async => TesterHelper.createMockDioResponse(
          json,
          HttpStatus.ok,
        ),
      );

      final _result = await _getComicsExternalDataSource(_search);
      expect(_result.isSuccess, true);
      expect(_result, isA<DataResult<List<ComicEntity>>>());
    });

    test('Should return error when call', () async {
      var _search = '';

      when(() => _httpService.get(any(), queryParameters: {
            'limit': 10,
            'offset': 0,
            'format': 'comic',
            'noVariants': true,
            'titleStartsWith': _search
          })).thenThrow(
        (_) async => TesterHelper.createMockDioResponse(
          jsonError,
          HttpStatus.badRequest,
        ),
      );
      final result = await _getComicsExternalDataSource(_search);
      expect(result.isSuccess, false);
      expect(result.error, isA<APIFailure>());
    });
  });
}

const json = '''
{
  "data": {
    "offset": 0,
    "limit": 1,
    "total": 7,
    "count": 1,
    "results": [
      {
        "id": 95815,
        "title": "Iron Man (2020) #24",
        "description": null,
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/70/62cf2852bf732",
          "extension": "jpg"
        }
      },
      {
        "id": 99743,
        "title": "Spider-Man (2022) #1",
        "description": null,
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/d/20/62cf28d9f39be",
          "extension": "jpg"
        }
      },
      {
        "id": 98668,
        "title": "Captain America: Symbol of Truth (2022) #6",
        "description": null,
        "thumbnail": {
          "path": "http://i.annihil.us/u/prod/marvel/i/mg/e/03/62cf280189349",
          "extension": "jpg"
        }
      }
    ]
  }
}
''';

const jsonError = '''
{
    "code": "MissingParameter",
    "message": "You must provide a hash."
}
''';
