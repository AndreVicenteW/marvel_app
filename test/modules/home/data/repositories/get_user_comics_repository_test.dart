import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_user_comics/get_user_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/repositories/get_user_comics_repository.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:mocktail/mocktail.dart';

class GetUserComicsDataSourceMock extends Mock
    implements GetUserComicsDataSource {}

void main() {
  var _getUserComicsDataSource = GetUserComicsDataSourceMock();
  var _getUserComicsRepository =
      GetUserComicsRepositoryImp(_getUserComicsDataSource);

  var _comicsList = [
    ComicEntity(
      0,
      'title',
      'description',
      ThumbnailEntity('', ''),
      false,
    )
  ];

  group('Add User Comic DataSource', () {
    test('Should return isSuccess true when is called', () async {
      when(() => _getUserComicsDataSource())
          .thenAnswer((_) async => DataResult.success(_comicsList));

      final _result = await _getUserComicsRepository();

      expect(_result.isSuccess, true);
    });

    test('Should return List of ComicEntity  when is called', () async {
      when(() => _getUserComicsDataSource())
          .thenAnswer((_) async => DataResult.success(_comicsList));

      final _result = await _getUserComicsRepository();

      expect(_result.data, isA<List<ComicEntity>>());
    });
  });
}
