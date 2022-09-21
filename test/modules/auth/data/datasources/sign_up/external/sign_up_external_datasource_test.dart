import 'dart:io';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_up/external/sign_up_external_datasource.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';
import '../../sign_in/external/sign_in_external_datasource_test.dart';

void main() {

  var _userEntity = UserEntity(
      email: 'test@test.com',
      password: '123456',
      name: 'test',
      id: ''
  );

  final _user = MockUser(
    isAnonymous: false,
    uid: '123aaasdf',
    email: 'test@test.com',
    displayName: 'Test',
  );

  group('Sign Up external data source test', () {

    test('Should return success when firebase is called', () async {

      var _firebaseAuth = MockFirebaseAuth(mockUser: _user);
      var _signUpExternalDataSource = SignUpExternalDataSourceImp(_firebaseAuth);

      final _result = await _signUpExternalDataSource(_userEntity);
      expect(_result.isSuccess, true);
    });

    test('Should return error when firebase is called', () async {

      var _firebaseAuth = FirebaseAuthMock();
      var _signUpExternalDataSource = SignUpExternalDataSourceImp(_firebaseAuth);

      when(() => _firebaseAuth.createUserWithEmailAndPassword(
        email: _userEntity.email,
        password: _userEntity.password ?? '',
      )).thenThrow(
            (_) async => TesterHelper.createMockDioResponse(
          jsonError,
          HttpStatus.badRequest,
        ),
      );
      final _result = await _signUpExternalDataSource(_userEntity);
      expect(_result.isSuccess, false);
      expect(_result.error, isA<APIFailure>());
    });
  });
}
