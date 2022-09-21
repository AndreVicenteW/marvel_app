import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';

abstract class AddUserComicDataSource {
  Future<DataResult> call(ComicDto entity);
}