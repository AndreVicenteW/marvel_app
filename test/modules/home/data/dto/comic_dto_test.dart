import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';

void main() {
  group('Comic DTO test', () {
    test('Should return a valid ComicDto when fromJson is called', () {
      final result = ComicDto.fromJson(jsonDecode(json));
      expect(result.title, 'Test');
    });

    test('Should return a valid JSON when toJson is called', () {
      final character = ComicDto.fromJson(jsonDecode(json));

      final result = character.toJson();
      expect(result['title'], 'Test');
    });

    test('Should return a valid ComicDto when fromEntity is called', () {
      final result = ComicDto.fromEntity(
        ComicEntity(
          1,
          'Test',
          '',
          ThumbnailEntity('', ''),
          false,
        ),
      );
      expect(result.title, 'Test');
    });

    test('Should return a valid JSON when toDatabase is called', () {
      final character = ComicDto.fromJson(jsonDecode(json));

      final result = character.toDatabase();
      expect(result['title'], 'Test');
    });

    test('Should return a valid ComicDto when fromDatabase is called', () {
      final result = ComicDto.fromDatabase(databaseData);
      expect(result.title, 'Test');
    });
  });
}

const json = '''
{
  "id": 1009189,
  "title": "Test",
  "description": "Test description",
  "thumbnail": {
    "path": "http://i.annihil.us/u/prod/marvel/i/mg/a/03/523219743a99b",
    "extension": "jpg"
  },
  "read": 0
}
''';

const databaseData =
{
  'id': 1009189,
  'title': 'Test',
  'description': 'Test description',
  'thumbnail': '{\"path\":\"http://i.annihil.us/u/prod/marvel/i/mg/9/90/62cf28519ea2f\",\"extension\":\"jpg\"}',
  'read': 0
}
;