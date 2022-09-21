import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/local_database_service/local_database_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/delete_user_comic/delete_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';

class DeleteUserComicInternalDataSourceImp extends DeleteUserComicDataSource {
  final LocalDatabaseService<ComicEntity> _localDatabaseService;

  DeleteUserComicInternalDataSourceImp(this._localDatabaseService);

  @override
  Future<DataResult> call(ComicEntity entity) async {
    try {
      await _localDatabaseService.delete(entity);

      return DataResult.success('');
    } catch (error) {
      return DataResult.failure(
        APIFailure('DeleteUserComicInternalDataSourceImp Error: $error'),
      );
    }
  }

}