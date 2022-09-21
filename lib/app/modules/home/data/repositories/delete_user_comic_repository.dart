import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/delete_user_comic/delete_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/delete_user_comic_repository.dart';

class DeleteUserComicRepositoryImp extends DeleteUserComicRepository {

  final DeleteUserComicDataSource _deleteUserComicDataSource;

  DeleteUserComicRepositoryImp(this._deleteUserComicDataSource);

  @override
  Future<DataResult> call(ComicEntity entity) {
    return _deleteUserComicDataSource(entity);
  }
}