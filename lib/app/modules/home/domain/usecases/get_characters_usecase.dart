import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_characters_repository.dart';

abstract class GetCharactersUseCase {
  Future<DataResult<List<CharacterEntity>>> call(String search,
      {bool pagination = false});
}

class GetCharactersUseCaseImp implements GetCharactersUseCase {
  final GetCharactersRepository _getCharactersRepository;

  GetCharactersUseCaseImp(this._getCharactersRepository);

  @override
  Future<DataResult<List<CharacterEntity>>> call(String search,
      {bool pagination = false}) {
    return _getCharactersRepository(search, pagination: pagination);
  }
}
