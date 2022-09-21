import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_in/sign_in_datasource.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/repositories/sign_in/sign_in_repository.dart';

class SignInRepositoryImp extends SignInRepository {
  final SignInDataSource _signInDataSource;

  SignInRepositoryImp(this._signInDataSource);

  @override
  Future<DataResult<UserEntity>> call(UserEntity userEntity) async {
    return _signInDataSource(userEntity);
  }
}