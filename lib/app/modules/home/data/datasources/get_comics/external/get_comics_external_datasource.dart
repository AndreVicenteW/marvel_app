import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/get_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/data/dto/pagination_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';

class GetComicsExternalDataSourceImp extends GetComicsDataSource {
  final HttpClientService _dio;

  GetComicsExternalDataSourceImp(this._dio);

  final String _comicsUrl = '${dotenv.env['MARVEL_URL']}/comics';
  final String _characterUrl = '${dotenv.env['MARVEL_URL']}/characters';

  PaginationDto? _pagination;

  @override
  Future<DataResult<List<ComicEntity>>> call(
    String search, {
    int? characterId,
    bool pagination = false,
  }) async {
    var _url = _comicsUrl;

    if (!pagination) {
      _pagination = null;
    }

    try {
      var queryParams = {
        'limit': 10,
        'offset': _pagination?.getNextOffset() ?? 0,
        'format': 'comic',
        'noVariants': true
      };

      if (characterId != null) {
        queryParams['characters'] = characterId;
        _url = '$_characterUrl/$characterId/comics';
      } else {
        queryParams['titleStartsWith'] = search;
      }

      final result = await _dio.get(_url, queryParameters: queryParams);

      var _result = PaginationDto.fromJson(result.data['data'], (data) {
        return ComicDto.fromJson(data as Map<String, dynamic>);
      });

      _pagination = _result;

      return DataResult.success(_result.results);
    } catch (error) {
      return DataResult.failure(
          APIFailure('GetComicsExternalDataSourceImp Error: $error'));
    }
  }
}
