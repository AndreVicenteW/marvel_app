import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/add_user_comic/add_user_comic_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/add_user_comic_repository.dart';

class AddUserComicRepositoryImp extends AddUserComicRepository {

  final AddUserComicDataSource _addUserComicDataSource;

  AddUserComicRepositoryImp(this._addUserComicDataSource);

  @override
  Future<DataResult> call(ComicEntity entity) {

    var dto = ComicDto.fromEntity(entity);

    return _addUserComicDataSource(dto);
  }
}