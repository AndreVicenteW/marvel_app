import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/usecases/sign_in/sign_in_usecase.dart';

abstract class SignInBloc extends Cubit<BaseBlocState> {
  SignInBloc(InitialState initialState) : super(initialState);

  Future<void> call(UserEntity userEntity);
}

class SignInBlocImp extends SignInBloc {
  final SignInUseCase _signInUseCase;

  SignInBlocImp(this._signInUseCase) : super(InitialState());

  @override
  Future<void> call(UserEntity userEntity) async {
    emit(LoadingState());

    var _result = await _signInUseCase(userEntity);

    if (_result.isSuccess) {
      emit(SuccessState(_result));
    } else {
      emit(ErrorState(_result.error.toString()));
    }
  }
}
