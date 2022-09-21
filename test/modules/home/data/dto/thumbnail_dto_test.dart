import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/dto/thumbnail_dto.dart';

void main() {

  group('Thumbnail DTO test', () {
    test('Should return a valid ThumbnailDto when fromJson is called', () {

      final result = ThumbnailDto.fromJson(jsonDecode(json));
      expect(result.extension, 'jpg');
    });

    test('Should return a valid JSON when toJson is called', () {

      final thumbnail = ThumbnailDto.fromJson(jsonDecode(json));

      final result = thumbnail.toJson();
      expect(result['extension'], 'jpg');
    });
  });
}

const json = '''
{
  "path": "http://i.annihil.us/u/prod/marvel/i/mg/a/03/523219743a99b",
  "extension": "jpg"
}
''';