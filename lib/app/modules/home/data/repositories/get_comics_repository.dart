import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/get_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_comics_repository.dart';

class GetComicsRepositoryImp extends GetComicsRepository {
  final GetComicsDataSource _externalDataSource;
  final GetComicsDataSource _internalDataSource;

  GetComicsRepositoryImp(this._externalDataSource, this._internalDataSource);

  @override
  Future<DataResult<List<ComicEntity>>> call(String search,
      {int? characterId, bool pagination = false}) {
    return search.isEmpty && characterId == null
        ? _internalDataSource(search)
        : _externalDataSource(search,
            characterId: characterId, pagination: pagination);
  }
}
