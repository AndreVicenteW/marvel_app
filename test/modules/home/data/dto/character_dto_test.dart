import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/dto/character_dto.dart';

void main() {

  group('Character DTO test', () {
    test('Should return a valid CharacterDto when fromJson is called', () {

      final result = CharacterDto.fromJson(jsonDecode(json));
      expect(result.name, 'Test');
    });

    test('Should return a valid JSON when toJson is called', () {

      final character = CharacterDto.fromJson(jsonDecode(json));

      final result = character.toJson();
      expect(result['name'], 'Test');
    });
  });
}

const json = '''
{
  "id": 1009189,
  "name": "Test",
  "description": "Test description",
  "thumbnail": {
    "path": "http://i.annihil.us/u/prod/marvel/i/mg/a/03/523219743a99b",
    "extension": "jpg"
  },
  "comics": {
    "available": 580
  }
}
''';