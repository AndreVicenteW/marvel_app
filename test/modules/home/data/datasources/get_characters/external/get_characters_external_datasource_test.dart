import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/external/get_characters_external_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/get_characters_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

void main() {

  late HttpClientService _httpService;
  late GetCharactersDataSource _getCharactersExternalDataSource;

  setUpAll(() async {
    await TesterHelper.init();
    _httpService = Modular.get();
    _getCharactersExternalDataSource = GetCharactersExternalDataSourceImp(_httpService);
  });

  group('Get characters external data source test', () {

    test('Should return list of CharacterEntity when success', () async {

      var _search = '';

      when(() => _httpService.get(
          any(),
          queryParameters: {
            'limit': 10,
            'nameStartsWith': _search,
            'offset': 0
          }
      )).thenAnswer(
            (_) async => TesterHelper.createMockDioResponse(
          json,
          HttpStatus.ok,
        ),
      );

      final _result = await _getCharactersExternalDataSource(_search);
      expect(_result.isSuccess, true);
      expect(_result, isA<DataResult<List<CharacterEntity>>>());
    });

    test('Should return error when call', () async {

      var _search = '';

      when(() => _httpService.get(
        any(),
          queryParameters: {
            'limit': 10,
            'nameStartsWith': _search,
            'offset': 0
          }
      )).thenThrow(
            (_) async => TesterHelper.createMockDioResponse(
          jsonError,
          HttpStatus.badRequest,
        ),
      );
      final result = await _getCharactersExternalDataSource(_search);
      expect(result.isSuccess, false);
      expect(result.error, isA<APIFailure>());
    });

  });
}

const json = '''
{
    "code": 200,
    "data": {
        "offset": 0,
        "limit": 1,
        "total": 7,
        "count": 1,
        "results": [
            {
                "id": 1009368,
                "name": "Iron Man",
                "description": "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.",
                "modified": "2016-09-28T12:08:19-0400",
                "thumbnail": {
                    "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55",
                    "extension": "jpg"
                },
                "resourceURI": "http://gateway.marvel.com/v1/public/characters/1009368",
                "comics": {
                    "available": 2601,
                    "collectionURI": "http://gateway.marvel.com/v1/public/characters/1009368/comics",
                    "items": [
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/comics/43495",
                            "name": "A+X (2012) #2"
                        }
                    ],
                    "returned": 20
                },
                "series": {
                    "available": 640,
                    "collectionURI": "http://gateway.marvel.com/v1/public/characters/1009368/series",
                    "items": [
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/16450",
                            "name": "A+X (2012 - 2014)"
                        }
                    ],
                    "returned": 20
                },
                "stories": {
                    "available": 3927,
                    "collectionURI": "http://gateway.marvel.com/v1/public/characters/1009368/stories",
                    "items": [
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/stories/670",
                            "name": "X-MEN (2004) #186",
                            "type": "cover"
                        }
                    ],
                    "returned": 20
                },
                "events": {
                    "available": 31,
                    "collectionURI": "http://gateway.marvel.com/v1/public/characters/1009368/events",
                    "items": [
                        {
                            "resourceURI": "http://gateway.marvel.com/v1/public/events/116",
                            "name": "Acts of Vengeance!"
                        }
                    ],
                    "returned": 20
                },
                "urls": [
                    {
                        "type": "detail",
                        "url": "http://marvel.com/comics/characters/1009368/iron_man?utm_campaign=apiRef&utm_source=be804f807f3f9deb8dd0412dd595ba2c"
                    }
                ]
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