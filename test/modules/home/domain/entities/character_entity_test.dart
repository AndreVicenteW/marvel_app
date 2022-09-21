import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

void main() {
  
  group('Character Entity test', () {
    test('Should return correct description when getDescription is called', () {

      var _charactersEntity = CharacterEntity(
        123,
        'test',
        'test description',
        ThumbnailEntity('path/to/file', 'jpg'),
        4,
      );

      final result = _charactersEntity.getDescription();
      expect(result, _charactersEntity.description);
    });

    test('Should return correct description when getDescription is called', () {

      var _charactersEntity = CharacterEntity(
        123,
        'test',
        '',
        ThumbnailEntity('path/to/file', 'jpg'),
        4,
      );

      final result = _charactersEntity.getDescription();
      expect(result, _charactersEntity.noDescriptionText);
    });
  });
}