import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/datasources/add_user_comic/add_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/add_user_comic/internal/add_user_comic_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/dto/thumbnail_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

void main() {
  late AddUserComicDataSource _addUserComicInternalDataSource;
  late MockLocalDatabaseService _mockLocalDatabaseService;

  final comic = ComicDto(
    1,
    'test',
    'test desc',
    ThumbnailDto('', ''),
    0,
  );

  setUpAll(() async {
    await TesterHelper.init();
    _mockLocalDatabaseService = MockLocalDatabaseService();
    _addUserComicInternalDataSource =
        AddUserComicInternalDataSourceImp(_mockLocalDatabaseService);
  });

  group('Add user comic data source test', () {
    test('Should return success', () async {
      when(() => _mockLocalDatabaseService.insert(
            comic,
          )).thenAnswer(
        (_) async => true,
      );

      final _result = await _addUserComicInternalDataSource(comic);
      expect(_result.isSuccess, true);
    });

    test('Should return error when call', () async {
      when(() => _mockLocalDatabaseService.insert(
          comic
      )).thenThrow(
            (_) async => '',
      );

      final _result = await _addUserComicInternalDataSource(comic);
      expect(_result.isSuccess, false);
    });
  });
}
