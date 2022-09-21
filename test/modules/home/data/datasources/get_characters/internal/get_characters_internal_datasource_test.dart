import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/get_characters_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/internal/get_characters_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

class MockRootBundle extends Mock implements AssetBundle {}

void main() {

  late GetCharactersDataSource _getCharactersInternalDataSource;
  late MockRootBundle _mockRootBundle;

  setUpAll(() async {
    await TesterHelper.init();
    _mockRootBundle = MockRootBundle();
    _getCharactersInternalDataSource = GetCharactersInternalDataSourceImp(_mockRootBundle);
  });

  group('Get characters internal data source test', () {

    test('Should return list of CharacterEntity when success', () async {

      when(() => _mockRootBundle.loadString(
          any()
      )).thenAnswer(
            (_) async => json,
      );

      final _result = await _getCharactersInternalDataSource('');
      expect(_result.isSuccess, true);
      expect(_result, isA<DataResult<List<CharacterEntity>>>());
    });

    test('Should return error when call', () async {

      when(() => _mockRootBundle.loadString(
          any()
      )).thenThrow(
            (_) async => jsonError,
      );

      final result = await _getCharactersInternalDataSource('');
      expect(result.isSuccess, false);
      expect(result.error, isA<APIFailure>());
    });
  });
}


const json = '''
{
    "data": {
        "results": [
            {
              "id": 1009189,
              "name": "Black Widow",
              "description": "Natasha Romanoff, also known as Black Widow, is a world-renowned super spy and one of S.H.I.E.L.D.'s top agents. Her hand-to-hand combat skills, intelligence, and unpredictability make her a deadly secret weapon. True to her mysterious nature, Black Widow comes and goes as she pleases, but always appears exactly when her particular skills are needed.",
              "thumbnail": {
                "path": "http://i.annihil.us/u/prod/marvel/i/mg/a/03/523219743a99b",
                "extension": "jpg"
              },
              "comics": {
                "available": 580
              }
            }
        ]
    }
}
''';

const jsonError = '''
''';