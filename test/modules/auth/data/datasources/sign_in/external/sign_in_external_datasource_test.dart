import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_in/external/sign_in_external_datasource.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../tester_helper.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

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

  group('Sign In external data source test', () {

    test('Should return success when firebase is called', () async {

      var _firebaseAuth = MockFirebaseAuth(mockUser: _user);
      var _signInExternalDataSource = SignInExternalDataSourceImp(_firebaseAuth);

      final _result = await _signInExternalDataSource(_userEntity);
      expect(_result.isSuccess, true);
    });

    test('Should return error when firebase is called', () async {

      var _firebaseAuth = FirebaseAuthMock();
      var _signInExternalDataSource = SignInExternalDataSourceImp(_firebaseAuth);

      when(() => _firebaseAuth.signInWithEmailAndPassword(
          email: _userEntity.email,
          password: _userEntity.password ?? '',
      )).thenThrow(
            (_) async => TesterHelper.createMockDioResponse(
          jsonError,
          HttpStatus.badRequest,
        ),
      );
      final _result = await _signInExternalDataSource(_userEntity);
      expect(_result.isSuccess, false);
      expect(_result.error, isA<APIFailure>());
    });

  });
}

const jsonError = '''
{
    "code": "AuthError",
    "message": "Wrong email or password"
}
''';
