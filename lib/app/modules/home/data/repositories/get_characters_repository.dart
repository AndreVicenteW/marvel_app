import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/get_characters_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_characters_repository.dart';

class GetCharactersRepositoryImp extends GetCharactersRepository {
  final GetCharactersDataSource _externalDataSource;
  final GetCharactersDataSource _internalDataSource;

  GetCharactersRepositoryImp(this._externalDataSource, this._internalDataSource);

  @override
  Future<DataResult<List<CharacterEntity>>> call(String search, {bool pagination = false}) async {
    return search.isEmpty ? _internalDataSource(search) : _externalDataSource(search, pagination: pagination);
  }
}