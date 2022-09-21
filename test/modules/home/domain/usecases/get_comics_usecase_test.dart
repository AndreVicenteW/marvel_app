import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_comics_repository.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_comics_usecase.dart';
import 'package:mocktail/mocktail.dart';

class GetComicsRepositoryMock extends Mock
    implements GetComicsRepository {}

void main() {
  var _getComicsRepository = GetComicsRepositoryMock();
  var _getComicsUseCase = GetComicsUseCaseImp(_getComicsRepository);

  var _comicsList = [
    ComicEntity(
      123,
      'test',
      'test description',
      ThumbnailEntity('', ''),
      false,
    )
  ];

  group('Get Comics UseCase test', () {
    test('Should return isSuccess true when repository is called', () async {
      when(() => _getComicsRepository(any()))
          .thenAnswer((_) async => DataResult.success(_comicsList));
      final _result = await _getComicsUseCase('');
      expect(_result.isSuccess, true);
    });

    test('Should return GenericFailure when repository is called', () async {
      when(() => _getComicsRepository(any())).thenAnswer(
          (_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _getComicsUseCase('');
      expect(_result.error, isA<GenericFailure>());
    });
  });
}
