import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';

abstract class SignInRepository {
  Future<DataResult<UserEntity>> call(UserEntity userEntity);
}