import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_comics_repository.dart';

abstract class GetComicsUseCase {
  Future<DataResult<List<ComicEntity>>> call(
    String search, {
    int? characterId,
    bool pagination = false,
  });
}

class GetComicsUseCaseImp implements GetComicsUseCase {
  final GetComicsRepository _getComicsRepository;

  GetComicsUseCaseImp(this._getComicsRepository);

  @override
  Future<DataResult<List<ComicEntity>>> call(
    String search, {
    int? characterId,
    bool pagination = false,
  }) {
    return _getComicsRepository(search,
        characterId: characterId, pagination: pagination);
  }
}
