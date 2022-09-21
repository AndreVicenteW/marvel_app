import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/get_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/data/repositories/get_comics_repository.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:mocktail/mocktail.dart';

class GetComicsDataSourceMock extends Mock implements GetComicsDataSource {}

void main() {
  var _externalDataSource = GetComicsDataSourceMock();
  var _internalDataSource = GetComicsDataSourceMock();

  var _getComicsRepository =
      GetComicsRepositoryImp(_externalDataSource, _internalDataSource);

  var _comicsList = [
    ComicEntity(
      0,
      'title',
      'description',
      ThumbnailEntity('', ''),
      false,
    )
  ];

  group('Get Comics Repository test external datasource', () {
    test('Should return isSuccess true when external data source is called',
        () async {
      when(() => _externalDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_comicsList));

      final _result = await _getComicsRepository('hulk');

      expect(_result.isSuccess, true);
    });

    test(
        'Should return List of ComicEntity  when external data source is called',
        () async {
      when(() => _externalDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_comicsList));

      final _result = await _getComicsRepository('hulk');

      expect(_result.data, isA<List<ComicEntity>>());
    });

    test('Should return empty List when external data source is called',
        () async {
      when(() => _externalDataSource(any()))
          .thenAnswer((_) async => DataResult.success([]));

      final _result = await _getComicsRepository('hulk');

      expect(_result.data?.length, 0);
    });
  });

  group('Get Comics Repository test internal datasource', () {
    test('Should return isSuccess true when internal data source is called',
        () async {
      when(() => _internalDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_comicsList));

      final _result = await _getComicsRepository('');

      expect(_result.isSuccess, true);
    });

    test(
        'Should return List of ComicEntity  when internal data source is called',
        () async {
      when(() => _internalDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_comicsList));

      final _result = await _getComicsRepository('');

      expect(_result.data, isA<List<ComicEntity>>());
    });

    test('Should return empty List when internal data source is called',
        () async {
      when(() => _internalDataSource(any()))
          .thenAnswer((_) async => DataResult.success([]));

      final _result = await _getComicsRepository('');

      expect(_result.data?.length, 0);
    });
  });
}
