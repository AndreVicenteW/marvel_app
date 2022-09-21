import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/repositories/sign_up/sign_up_repository.dart';

abstract class SignUpUseCase {
  Future<DataResult<UserEntity>> call(UserEntity userEntity);
}

class SignUpUseCaseImp extends SignUpUseCase {
  final SignUpRepository _signUpRepository;

  SignUpUseCaseImp(this._signUpRepository);

  @override
  Future<DataResult<UserEntity>> call(UserEntity userEntity) async {

    if (!userEntity.isValidEmail) {
      return DataResult.failure(GenericFailure('Invalid email'));
    } else if (!userEntity.isValidPassword) {
      return DataResult.failure(GenericFailure('Invalid password'));
    }

    return _signUpRepository(userEntity);
  }
}