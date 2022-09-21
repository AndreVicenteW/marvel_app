import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/get_characters_datasource.dart';
import 'package:marvel_app/app/modules/home/data/repositories/get_characters_repository.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:mocktail/mocktail.dart';

class GetCharactersDataSourceMock extends Mock
    implements GetCharactersDataSource {}

void main() {
  var _externalDataSource = GetCharactersDataSourceMock();
  var _internalDataSource = GetCharactersDataSourceMock();
  var _getCharactersRepository =
      GetCharactersRepositoryImp(_externalDataSource, _internalDataSource);

  var _charactersList = [
    CharacterEntity(
      123,
      'test',
      'test description',
      ThumbnailEntity('', ''),
      4,
    )
  ];

  group('Get Characters Repository test external datasource', () {
    test('Should return isSuccess true when external data source is called',
        () async {
      when(() => _externalDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_charactersList));

      final _result = await _getCharactersRepository('hulk');

      expect(_result.isSuccess, true);
    });

    test(
        'Should return List of CharacterEntity  when external data source is called',
        () async {
      when(() => _externalDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_charactersList));

      final _result = await _getCharactersRepository('hulk');

      expect(_result.data, isA<List<CharacterEntity>>());
    });

    test('Should return empty List when external data source is called',
        () async {
      when(() => _externalDataSource(any()))
          .thenAnswer((_) async => DataResult.success([]));

      final _result = await _getCharactersRepository('hulk');

      expect(_result.data?.length, 0);
    });
  });

  group('Get Characters Repository test internal datasource', () {
    test('Should return isSuccess true when internal data source is called',
            () async {
          when(() => _internalDataSource(any()))
              .thenAnswer((_) async => DataResult.success(_charactersList));

          final _result = await _getCharactersRepository('');

          expect(_result.isSuccess, true);
        });

    test(
        'Should return List of CharacterEntity  when internal data source is called',
            () async {
          when(() => _internalDataSource(any()))
              .thenAnswer((_) async => DataResult.success(_charactersList));

          final _result = await _getCharactersRepository('');

          expect(_result.data, isA<List<CharacterEntity>>());
        });

    test('Should return empty List when internal data source is called',
            () async {
          when(() => _internalDataSource(any()))
              .thenAnswer((_) async => DataResult.success([]));

          final _result = await _getCharactersRepository('');

          expect(_result.data, isA<List<CharacterEntity>>());
        });
  });
}
