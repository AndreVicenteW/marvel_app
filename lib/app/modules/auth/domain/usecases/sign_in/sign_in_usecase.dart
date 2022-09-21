import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/repositories/sign_in/sign_in_repository.dart';

abstract class SignInUseCase {
  Future<DataResult<UserEntity>> call(UserEntity userEntity);
}

class SignInUseCaseImp implements SignInUseCase {
  final SignInRepository _signInRepository;

  SignInUseCaseImp(this._signInRepository);

  @override
  Future<DataResult<UserEntity>> call(UserEntity userEntity) async {

    if (!userEntity.isValidEmail) {
      return DataResult.failure(GenericFailure('Invalid email'));
    } else if (!userEntity.isValidPassword) {
      return DataResult.failure(GenericFailure('Invalid password'));
    }

    return _signInRepository(userEntity);
  }
}
