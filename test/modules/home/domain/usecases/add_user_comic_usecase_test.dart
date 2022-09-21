import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/add_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/add_user_comic_usecase.dart';
import 'package:mocktail/mocktail.dart';

class AddUserComicRepositoryMock extends Mock
    implements AddUserComicRepository {}

void main() {
  var _addUserComicRepository = AddUserComicRepositoryMock();
  var _addUserComicUseCase = AddUserComicUseCaseImp(_addUserComicRepository);

  var _comic = ComicEntity(
    123,
    'test',
    'test description',
    ThumbnailEntity('', ''),
    false,
  );

  var _comicsList = [
    _comic
  ];

  group('Get Comics UseCase test', () {
    test('Should return isSuccess true when repository is called', () async {
      when(() => _addUserComicRepository(_comic))
          .thenAnswer((_) async => DataResult.success(_comicsList));
      final _result = await _addUserComicUseCase(_comic);
      expect(_result.isSuccess, true);
    });

    test('Should return GenericFailure when repository is called', () async {
      when(() => _addUserComicRepository(_comic)).thenAnswer(
          (_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _addUserComicUseCase(_comic);
      expect(_result.error, isA<GenericFailure>());
    });
  });
}
