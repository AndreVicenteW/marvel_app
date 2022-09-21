import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_user_comics/get_user_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_user_comics_repository.dart';

class GetUserComicsRepositoryImp extends GetUserComicsRepository {

  final GetUserComicsDataSource _internalUserComicsDataSource;

  GetUserComicsRepositoryImp(this._internalUserComicsDataSource);

  @override
  Future<DataResult<List<ComicEntity>>> call() {
    return _internalUserComicsDataSource();
  }
}