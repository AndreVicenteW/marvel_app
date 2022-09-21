import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_user_comics_usecase.dart';

abstract class GetUserComicsBloc extends Cubit<BaseBlocState> {
  GetUserComicsBloc(InitialState initialState) : super(initialState);

  List<ComicEntity> listRead = [];
  List<ComicEntity> listToRead = [];

  Future<void> call();

  bool checkUserComic(ComicEntity entity);
}

class GetUserComicsBlocImp extends GetUserComicsBloc {
  final GetUserComicsUseCase _getUserComicsUseCase;

  GetUserComicsBlocImp(this._getUserComicsUseCase) : super(InitialState());

  @override
  Future<void> call() async {
    emit(LoadingState());

    listToRead = [];
    listRead = [];

    var _result = await _getUserComicsUseCase();

    if (_result.isSuccess) {
      _result.data?.map((comic) {
        if (comic.alreadyRead) {
          listRead.add(comic);
        } else {
          listToRead.add(comic);
        }
      }).toList();

      emit(SuccessState(true));
    } else {
      emit(ErrorState(_result.error.toString()));
    }
  }

  @override
  bool checkUserComic(ComicEntity entity) {
    if ((listToRead.where((element) => element.id == entity.id).isNotEmpty) ||
        listRead.where((element) => element.id == entity.id).isNotEmpty) {
      return true;
    } else {
      return false;
    }

    //return listToRead.contains(entity) || listRead.contains(entity);
  }
}
