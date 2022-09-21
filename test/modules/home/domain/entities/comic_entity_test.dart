import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

void main() {

  group('Comic Entity test', () {
    test('Should return correct description when getDescription is called', () {

      var _comicsEntity = ComicEntity(
        123,
        'test',
        'test description',
        ThumbnailEntity('path/to/file', 'jpg'),
        true,
      );

      final result = _comicsEntity.getDescription();
      expect(result, _comicsEntity.description);
    });

    test('Should return correct description when getDescription is called', () {

      var _comicsEntity = ComicEntity(
        123,
        'test',
        '',
        ThumbnailEntity('path/to/file', 'jpg'),
        true,
      );

      final result = _comicsEntity.getDescription();
      expect(result, _comicsEntity.noDescriptionText);
    });

    test('Should copy the object with different alreadyRead param', () {

      var _comicsEntity = ComicEntity(
        123,
        'test',
        '',
        ThumbnailEntity('path/to/file', 'jpg'),
        true,
      );

      final result = _comicsEntity.copyWith(alreadyRead: false);
      expect(result.alreadyRead, false);
    });

    test('Should copy the object with different title param', () {

      var _comicsEntity = ComicEntity(
        123,
        'test',
        '',
        ThumbnailEntity('path/to/file', 'jpg'),
        true,
      );

      final result = _comicsEntity.copyWith(title: 'changed title');
      expect(result.title, 'changed title');
    });
  });
}