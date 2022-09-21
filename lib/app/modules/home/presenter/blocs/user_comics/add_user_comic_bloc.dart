import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/add_user_comic_usecase.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/user_comics/get_user_comics_bloc.dart';

abstract class AddUserComicBloc extends Cubit<BaseBlocState> {
  AddUserComicBloc(InitialState initialState) : super(initialState);

  Future<void> call(ComicEntity comicEntity, bool read);
}

class AddUserComicBlocImp extends AddUserComicBloc {
  final AddUserComicUseCase _addUserComicUseCase;
  final GetUserComicsBloc _getUserComicsBloc;

  AddUserComicBlocImp(
    this._addUserComicUseCase,
    this._getUserComicsBloc,
  ) : super(InitialState());

  @override
  Future<void> call(ComicEntity comicEntity, bool read) async {
    emit(LoadingState());

    var _comic = comicEntity.copyWith(alreadyRead: read);

    var _result = await _addUserComicUseCase(_comic);

    if (_result.isSuccess) {
      if(read) {
        _getUserComicsBloc.listRead.add(comicEntity);
      } else {
        _getUserComicsBloc.listToRead.add(comicEntity);
      }
      emit(SuccessState(read));
    } else {
      emit(ErrorState(_result.error.toString()));
    }
  }
}
