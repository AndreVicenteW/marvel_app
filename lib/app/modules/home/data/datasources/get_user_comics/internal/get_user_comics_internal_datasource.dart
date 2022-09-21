import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/local_database_service/local_database_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_user_comics/get_user_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';

class GetUserComicsInternalDataSourceImp extends GetUserComicsDataSource {
  final LocalDatabaseService<ComicEntity> _localDatabaseService;

  GetUserComicsInternalDataSourceImp(this._localDatabaseService);

  @override
  Future<DataResult<List<ComicEntity>>> call() async {
    try {
      final response = await _localDatabaseService.getAll();

      return DataResult.success(response);
    } catch (error) {
      return DataResult.failure(
        APIFailure('GetUserComicsInternalDataSourceImp Error: $error'),
      );
    }
  }
}
