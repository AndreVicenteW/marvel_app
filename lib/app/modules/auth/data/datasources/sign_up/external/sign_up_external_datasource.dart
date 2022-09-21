import 'package:firebase_auth/firebase_auth.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';

class SignUpExternalDataSourceImp extends SignUpDataSource {
  final FirebaseAuth _firebaseAuth;

  SignUpExternalDataSourceImp(this._firebaseAuth);

  @override
  Future<DataResult<UserEntity>> call(UserEntity userEntity) async {
    try {

      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: userEntity.password ?? '',
      );
      return DataResult.success(UserEntity(
        id: _user.user?.uid ?? '',
        email: userEntity.email,
        name: _user.user?.displayName,
      ));
    } catch (e) {
      return DataResult.failure(APIFailure('Error on sign up'));
    }
  }
}
