import 'package:firebase_auth/firebase_auth.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';

class SignInExternalDataSourceImp extends SignInDataSource {
  final FirebaseAuth _firebaseAuth;

  SignInExternalDataSourceImp(this._firebaseAuth);

  @override
  Future<DataResult<UserEntity>> call(UserEntity userEntity) async {
    try {
      var _user = await _firebaseAuth.signInWithEmailAndPassword(
        email: userEntity.email,
        password: userEntity.password ?? '',
      );
      return DataResult.success(UserEntity(
        id: _user.user?.uid ?? '',
        email: userEntity.email,
        name: _user.user?.displayName,
      ));
    } catch (e) {
      return DataResult.failure(APIFailure('Invalid email or password'));
    }
  }
}
