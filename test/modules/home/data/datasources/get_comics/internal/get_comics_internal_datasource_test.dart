import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/get_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/internal/get_comics_internal_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';
import '../../get_characters/internal/get_characters_internal_datasource_test.dart';

void main() {

  late GetComicsDataSource _getComicsInternalDataSource;
  late MockRootBundle _mockRootBundle;

  setUpAll(() async {
    await TesterHelper.init();
    _mockRootBundle = MockRootBundle();
    _getComicsInternalDataSource = GetComicsInternalDataSourceImp(_mockRootBundle);
  });

  group('Get comics internal data source test', () {

    test('Should return list of ComicEntity when success', () async {

      when(() => _mockRootBundle.loadString(
          any()
      )).thenAnswer(
            (_) async => json,
      );

      final _result = await _getComicsInternalDataSource('');
      expect(_result.isSuccess, true);
      expect(_result, isA<DataResult<List<ComicEntity>>>());
    });

    test('Should return error when call', () async {

      when(() => _mockRootBundle.loadString(
          any()
      )).thenThrow(
            (_) async => jsonError,
      );

      final result = await _getComicsInternalDataSource('');
      expect(result.isSuccess, false);
      expect(result.error, isA<APIFailure>());
    });
  });
}

const json = '''
{
    "data": {
        "results": [
            {
              "id": 95815,
              "title": "Iron Man (2020) #24",
              "description": null,
              "thumbnail": {
                "path": "http://i.annihil.us/u/prod/marvel/i/mg/6/70/62cf2852bf732",
                "extension": "jpg"
              }
            }
        ]
    }
}
''';

const jsonError = '''
''';