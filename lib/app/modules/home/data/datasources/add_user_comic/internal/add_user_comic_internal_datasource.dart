import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/core/services/local_database_service/local_database_service.dart';
import 'package:marvel_app/app/modules/home/data/datasources/add_user_comic/add_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';

class AddUserComicInternalDataSourceImp extends AddUserComicDataSource {
  final LocalDatabaseService<ComicDto> _localDatabaseService;

  AddUserComicInternalDataSourceImp(this._localDatabaseService);

  @override
  Future<DataResult> call(ComicDto entity) async {
    try {
      await _localDatabaseService.insert(entity);

      return DataResult.success('');
    } catch (error) {
      return DataResult.failure(
        APIFailure('AddUserComicInternalDataSourceImp Error: $error'),
      );
    }
  }

}