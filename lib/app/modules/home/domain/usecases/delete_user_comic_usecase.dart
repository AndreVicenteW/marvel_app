import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/delete_user_comic_repository.dart';

abstract class DeleteUserComicUseCase {
  Future<DataResult> call(ComicEntity entity);
}

class DeleteUserComicUseCaseImp implements DeleteUserComicUseCase {
  final DeleteUserComicRepository _deleteUserComicRepository;

  DeleteUserComicUseCaseImp(this._deleteUserComicRepository);

  @override
  Future<DataResult> call(ComicEntity entity) {
    return _deleteUserComicRepository(entity);
  }
}