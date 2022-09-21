import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_user_comics/get_user_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_user_comics/internal/get_user_comics_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/dto/thumbnail_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

void main() {
  late GetUserComicsDataSource _getUserComicsInternalDataSource;
  late MockLocalDatabaseService _mockLocalDatabaseService;

  setUpAll(() async {
    await TesterHelper.init();
    _mockLocalDatabaseService = MockLocalDatabaseService();
    _getUserComicsInternalDataSource =
        GetUserComicsInternalDataSourceImp(_mockLocalDatabaseService);
  });

  group('Get user comics internal data source test', () {
    test('Should return list of ComicEntity when success', () async {
      when(() => _mockLocalDatabaseService.getAll()).thenAnswer(
        (_) async => listSuccess,
      );

      final _result = await _getUserComicsInternalDataSource();
      expect(_result.isSuccess, true);
    });

    test('Should return error when call', () async {
      when(() => _mockLocalDatabaseService.getAll()).thenThrow(
        (_) async => '',
      );

      final _result = await _getUserComicsInternalDataSource();
      expect(_result.isSuccess, false);
    });
  });
}

final listSuccess = [
  ComicDto(
    1,
    'test',
    'test desc',
    ThumbnailDto('', ''),
    0,
  )
];
