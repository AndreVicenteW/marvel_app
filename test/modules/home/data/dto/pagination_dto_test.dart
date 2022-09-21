import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/data/dto/pagination_dto.dart';

void main() {

  group('Pagination DTO test', () {
    test('Should return a valid PaginationDto when fromJson is called', () {

      final result = PaginationDto.fromJson(jsonDecode(json), (_) => true);
      expect(result.limit, 10);
    });

    test('Should return a valid JSON when toJson is called', () {

      final pagination = PaginationDto.fromJson(jsonDecode(json), (_) => true);

      final result = pagination.toJson((_) => true);
      expect(result['limit'], 10);
    });

    test('Should return next offset', () {

      final pagination = PaginationDto.fromJson(jsonDecode(json), (_) => true);

      final result = pagination.getNextOffset();
      expect(result, 2);
    });
  });
}

const json = '''
{
  "offset": 0,
  "limit": 10,
  "total": 12,
  "count": 2,
  "results": []
}
''';