import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/add_user_comic_repository.dart';

abstract class AddUserComicUseCase {
  Future<DataResult> call(ComicEntity entity);
}

class AddUserComicUseCaseImp implements AddUserComicUseCase {
  final AddUserComicRepository _addUserComicRepository;

  AddUserComicUseCaseImp(this._addUserComicRepository);

  @override
  Future<DataResult> call(ComicEntity entity) {
    return _addUserComicRepository(entity);
  }
}