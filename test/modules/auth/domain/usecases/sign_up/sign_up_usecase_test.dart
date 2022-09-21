import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/repositories/sign_up/sign_up_repository.dart';
import 'package:marvel_app/app/modules/auth/domain/usecases/sign_up/sign_up_usecase.dart';
import 'package:mocktail/mocktail.dart';

class SignUpRepositoryMock extends Mock implements SignUpRepository {}

void main() {

  var _signUpRepository = SignUpRepositoryMock();
  var _signUpUseCase = SignUpUseCaseImp(_signUpRepository);

  var _userEntity = UserEntity(
      email: 'test@test.com',
      password: '123456',
      name: 'test',
      id: ''
  );

  setUpAll(() {
    registerFallbackValue(_userEntity);
  });

  group('Sign Up UseCase test', () {

    test('Should return isSuccess true when repository is called', () async {
      when(() => _signUpRepository(any())).thenAnswer((_) async => DataResult.success(_userEntity));
      final _result = await _signUpUseCase(_userEntity);
      expect(_result.isSuccess, true);
    });

    test('Should return UserEntity when repository is called', () async {
      when(() => _signUpRepository(any())).thenAnswer((_) async => DataResult.success(_userEntity));
      final _result = await _signUpUseCase(_userEntity);
      expect(_result.data, isA<UserEntity>());
    });

    test('Should return isSuccess false when repository is called', () async {
      when(() => _signUpRepository(any())).thenAnswer((_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _signUpUseCase(_userEntity);
      expect(_result.isSuccess, false);
    });

    test('Should return GenericFailure when repository is called', () async {
      when(() => _signUpRepository(any())).thenAnswer((_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _signUpUseCase(_userEntity);
      expect(_result.error, isA<GenericFailure>());
    });

    test('Should return GenericFailure when password is empty', () async {
      final _result = await _signUpUseCase(UserEntity(
          email: 'test@test.com',
          password: '',
          id: ''
      ));
      expect(_result.error, isA<GenericFailure>());
    });

    test('Should return GenericFailure when email is invalid', () async {
      final _result = await _signUpUseCase(UserEntity(
          email: 'test',
          password: '',
          id: ''
      ));
      expect(_result.error, isA<GenericFailure>());
    });

    test('Should return GenericFailure when email is empty', () async {
      final _result = await _signUpUseCase(UserEntity(
          email: '',
          password: '',
          id: ''
      ));
      expect(_result.error, isA<GenericFailure>());
    });
  });
}
