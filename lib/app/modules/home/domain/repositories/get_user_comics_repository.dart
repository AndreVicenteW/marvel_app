import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';

abstract class GetUserComicsRepository {
  Future<DataResult<List<ComicEntity>>> call();
}