import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_user_comics_repository.dart';

abstract class GetUserComicsUseCase {
  Future<DataResult<List<ComicEntity>>> call();
}

class GetUserComicsUseCaseImp implements GetUserComicsUseCase {
  final GetUserComicsRepository _getUserComicsRepository;

  GetUserComicsUseCaseImp(this._getUserComicsRepository);

  @override
  Future<DataResult<List<ComicEntity>>> call() {
    return _getUserComicsRepository();
  }
}