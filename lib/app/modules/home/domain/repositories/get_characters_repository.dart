import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';

abstract class GetCharactersRepository {
  Future<DataResult<List<CharacterEntity>>> call(String search, {bool pagination = false});
}