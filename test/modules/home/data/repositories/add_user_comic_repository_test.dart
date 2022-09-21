import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/add_user_comic/add_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/repositories/add_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:mocktail/mocktail.dart';

class AddUserComicDataSourceMock extends Mock
    implements AddUserComicDataSource {}

void main() {
  var _addUserComicDataSource = AddUserComicDataSourceMock();
  var _addUserComicRepository = AddUserComicRepositoryImp(
      _addUserComicDataSource);

  var _comicEntity = ComicEntity(
    0,
    'title',
    'description',
    ThumbnailEntity('', ''),
    false,
  );
  
  setUpAll(() {
    registerFallbackValue(ComicDto.fromEntity(_comicEntity));
  });

  group('Add User Comic DataSource', () {
    test('Should return isSuccess true when is called', () async {

      when(() => _addUserComicDataSource(any())).thenAnswer((_) async =>
          DataResult.success(true));

      final _result = await _addUserComicRepository(_comicEntity);

      expect(_result.isSuccess, true);
    });
  });
}