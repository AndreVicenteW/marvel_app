import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/delete_user_comic_repository.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/delete_user_comic_usecase.dart';
import 'package:mocktail/mocktail.dart';

class DeleteUserComicRepositoryMock extends Mock
    implements DeleteUserComicRepository {}

void main() {
  var _deleteUserComicRepository = DeleteUserComicRepositoryMock();
  var _deleteUserComicUseCase = DeleteUserComicUseCaseImp(_deleteUserComicRepository);

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
      when(() => _deleteUserComicRepository(_comic))
          .thenAnswer((_) async => DataResult.success(_comicsList));
      final _result = await _deleteUserComicUseCase(_comic);
      expect(_result.isSuccess, true);
    });

    test('Should return GenericFailure when repository is called', () async {
      when(() => _deleteUserComicRepository(_comic)).thenAnswer(
          (_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _deleteUserComicUseCase(_comic);
      expect(_result.error, isA<GenericFailure>());
    });
  });
}
