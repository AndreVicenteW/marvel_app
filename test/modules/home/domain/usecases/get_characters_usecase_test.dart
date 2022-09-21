import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/domain/repositories/get_characters_repository.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_characters_usecase.dart';
import 'package:mocktail/mocktail.dart';

class GetCharactersRepositoryMock extends Mock
    implements GetCharactersRepository {}

void main() {
  var _getCharactersRepository = GetCharactersRepositoryMock();
  var _getCharactersUseCase = GetCharactersUseCaseImp(_getCharactersRepository);

  var _charactersList = [
    CharacterEntity(
      123,
      'test',
      'test description',
      ThumbnailEntity('', ''),
      4,
    )
  ];

  group('Get Characters UseCase test', () {
    test('Should return isSuccess true when repository is called', () async {
      when(() => _getCharactersRepository(any()))
          .thenAnswer((_) async => DataResult.success(_charactersList));
      final _result = await _getCharactersUseCase('');
      expect(_result.isSuccess, true);
    });

    test('Should return GenericFailure when repository is called', () async {
      when(() => _getCharactersRepository(any())).thenAnswer(
          (_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _getCharactersUseCase('');
      expect(_result.error, isA<GenericFailure>());
    });
  });
}
