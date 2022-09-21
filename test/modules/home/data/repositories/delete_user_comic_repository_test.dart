import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/delete_user_comic/delete_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/repositories/delete_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:mocktail/mocktail.dart';

class DeleteUserComicDataSourceMock extends Mock
    implements DeleteUserComicDataSource {}

void main() {
  var _deleteUserComicDataSource = DeleteUserComicDataSourceMock();
  var _deleteUserComicRepository = DeleteUserComicRepositoryImp(
      _deleteUserComicDataSource);

  var _comicEntity = ComicEntity(
    0,
    'title',
    'description',
    ThumbnailEntity('', ''),
    false,
  );

  group('Delete User Comic DataSource', () {
    test('Should return isSuccess true when is called', () async {

      when(() => _deleteUserComicDataSource(_comicEntity)).thenAnswer((_) async =>
          DataResult.success(true));

      final _result = await _deleteUserComicRepository(_comicEntity);

      expect(_result.isSuccess, true);
    });
  });
}