import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:marvel_app/app/modules/auth/data/repositories/sign_in/sign_in_repository.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:mocktail/mocktail.dart';

class SignInDataSourceMock extends Mock implements SignInDataSource {}

void main() {
  var _signInDataSource = SignInDataSourceMock();
  var _signInRepository = SignInRepositoryImp(_signInDataSource);

  var _userEntity = UserEntity(
      id: '',
      email: 'test@test.com',
      password: '123456',
      name: 'test');

  setUpAll(() {
    registerFallbackValue(_userEntity);
  });

  group('Sign In Repository test', () {
    test('Should return isSuccess true when data source is called', () async {
      when(() => _signInDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_userEntity));
      final _result = await _signInRepository(_userEntity);
      expect(_result.isSuccess, true);
    });

    test('Should return UserEntity when data source is called', () async {
      when(() => _signInDataSource(any()))
          .thenAnswer((_) async => DataResult.success(_userEntity));
      final _result = await _signInRepository(_userEntity);
      expect(_result.data, isA<UserEntity>());
    });

    test('Should return isSuccess false when data source is called', () async {
      when(() => _signInDataSource(any()))
          .thenAnswer((_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _signInRepository(_userEntity);
      expect(_result.isSuccess, false);
    });

    test('Should return GenericFailure when data source is called', () async {
      when(() => _signInDataSource(any()))
          .thenAnswer((_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _signInRepository(_userEntity);
      expect(_result.error, isA<GenericFailure>());
    });
  });
}
