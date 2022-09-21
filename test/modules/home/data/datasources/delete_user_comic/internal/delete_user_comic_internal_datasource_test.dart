import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/datasources/delete_user_comic/delete_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/delete_user_comic/internal/delete_user_comic_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/dto/thumbnail_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

void main() {
  late DeleteUserComicDataSource _deleteUserComicInternalDataSource;
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
    _deleteUserComicInternalDataSource =
        DeleteUserComicInternalDataSourceImp(_mockLocalDatabaseService);
  });

  group('Delete user comic data source test', () {
    test('Should return success', () async {
      when(() => _mockLocalDatabaseService.delete(
            comic,
          )).thenAnswer(
        (_) async => true,
      );

      final _result = await _deleteUserComicInternalDataSource(comic);
      expect(_result.isSuccess, true);
    });

    test('Should return error when call', () async {
      when(() => _mockLocalDatabaseService.delete(
          comic
      )).thenThrow(
            (_) async => '',
      );

      final _result = await _deleteUserComicInternalDataSource(comic);
      expect(_result.isSuccess, false);
    });
  });
}
