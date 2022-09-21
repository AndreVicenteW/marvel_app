import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/http_client_service/http_client_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/get_characters_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/character_dto.dart';
import 'package:marvel_app/app/modules/home/data/dto/pagination_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';

class GetCharactersExternalDataSourceImp extends GetCharactersDataSource {
  final HttpClientService _dio;

  GetCharactersExternalDataSourceImp(this._dio);

  final String _url = '${dotenv.env['MARVEL_URL']}/characters';
  PaginationDto? _pagination;

  @override
  Future<DataResult<List<CharacterEntity>>> call(String search, {bool pagination = false}) async {

    if(!pagination) {
      _pagination = null;
    }

    try {
      final result = await _dio.get(
          _url,
          queryParameters: {
            'limit': 10,
            'nameStartsWith': search,
            'offset': _pagination?.getNextOffset() ?? 0
          }
      );

      var _result = PaginationDto<CharacterDto>.fromJson(result.data['data'], (data) {
        return CharacterDto.fromJson(data as Map<String, dynamic>);
      });

      _pagination = _result;

      return DataResult.success(_result.results);

    } catch (error) {
      return DataResult.failure(APIFailure('GetCharactersDataSourceImp Error: $error'));
    }
  }
}