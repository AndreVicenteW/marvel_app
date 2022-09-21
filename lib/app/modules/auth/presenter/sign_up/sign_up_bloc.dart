import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/auth/domain/entities/user_entity.dart';
import 'package:marvel_app/app/modules/auth/domain/usecases/sign_up/sign_up_usecase.dart';

abstract class SignUpBloc extends Cubit<BaseBlocState> {
  SignUpBloc(InitialState initialState) : super(initialState);

  Future<void> call(UserEntity userEntity);
}

class SignUpBlocImp extends SignUpBloc {
  final SignUpUseCase _signUpUseCase;

  SignUpBlocImp(this._signUpUseCase) : super(InitialState());

  @override
  Future<void> call(UserEntity userEntity) async {

    emit(LoadingState());

    var _result = await _signUpUseCase(userEntity);

    if (_result.isSuccess) {
      emit(SuccessState(_result));
    } else {
      emit(ErrorState(_result.error.toString()));
    }
  }
}