import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/repositories/sign_up/sign_up_repository.dart';

class SignUpRepositoryImp extends SignUpRepository {
  final SignUpDataSource _signUpDataSource;

  SignUpRepositoryImp(this._signUpDataSource);

  @override
  Future<DataResult<UserEntity>> call(UserEntity userEntity) async {
    return _signUpDataSource(userEntity);
  }
}