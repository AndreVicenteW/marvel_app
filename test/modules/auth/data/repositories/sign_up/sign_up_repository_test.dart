import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:marvel_app/app/modules/auth/data/repositories/sign_up/sign_up_repository.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:mocktail/mocktail.dart';

class SignUpDataSourceMock extends Mock implements SignUpDataSource {}

void main() {
  
  var _signUpDataSource = SignUpDataSourceMock();
  var _signUpRepository = SignUpRepositoryImp(_signUpDataSource);

  var _userEntity = UserEntity(
      email: 'test@test.com',
      password: '123456',
      name: 'test',
      id: ''
  );

  setUpAll(() {
    registerFallbackValue(_userEntity);
  });
  
  group('Sign Up Repository test', () {

    test('Should return isSuccess true when data source is called', () async {
      when(() => _signUpDataSource(any())).thenAnswer((_) async => DataResult.success(_userEntity));
      final _result = await _signUpRepository(_userEntity);
      expect(_result.isSuccess, true);
    });

    test('Should return UserEntity when data source is called', () async {
      when(() => _signUpDataSource(any())).thenAnswer((_) async => DataResult.success(_userEntity));
      final _result = await _signUpRepository(_userEntity);
      expect(_result.data, isA<UserEntity>());
    });

    test('Should return isSuccess false when data source is called', () async {
      when(() => _signUpDataSource(any())).thenAnswer((_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _signUpRepository(_userEntity);
      expect(_result.isSuccess, false);
    });

    test('Should return GenericFailure when data source is called', () async {
      when(() => _signUpDataSource(any())).thenAnswer((_) async => DataResult.failure(GenericFailure('Test error')));
      final _result = await _signUpRepository(_userEntity);
      expect(_result.error, isA<GenericFailure>());
    });
  });
}