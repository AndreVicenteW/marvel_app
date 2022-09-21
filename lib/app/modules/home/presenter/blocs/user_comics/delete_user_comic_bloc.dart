import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/delete_user_comic_usecase.dart';

abstract class DeleteUserComicBloc extends Cubit<BaseBlocState> {
  DeleteUserComicBloc(InitialState initialState) : super(initialState);

  Future<void> call(ComicEntity comicEntity);
}

class DeleteUserComicBlocImp extends DeleteUserComicBloc {
  final DeleteUserComicUseCase _deleteUserComicUseCase;

  DeleteUserComicBlocImp(
      this._deleteUserComicUseCase,
      ) : super(InitialState());

  @override
  Future<void> call(ComicEntity comicEntity) async {
    emit(LoadingState());

    var _result = await _deleteUserComicUseCase(comicEntity);

    if(_result.isSuccess) {
      emit(SuccessState(true));
    } else {
      emit(ErrorState(_result.error.toString()));
    }
  }
}