import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_comics_usecase.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_bloc.dart';

class SearchComicsBlocImp extends SearchBloc<ComicEntity> {

  final GetComicsUseCase _getComicsUseCase;

  SearchComicsBlocImp(this._getComicsUseCase) : super(InitialState());

  @override
  Future<void> call(String search,
      {int? characterId, bool pagination = false}) async {

    if(!pagination) {
      list = [];
    }

    emit(LoadingState());

    var _result = await _getComicsUseCase(search,
        characterId: characterId, pagination: pagination);

    if (_result.isSuccess) {
      if (pagination) {
        list.addAll(_result.data!);
      } else {
        list = _result.data ?? [];
      }

      emit(SuccessState(list));
    } else {
      emit(ErrorState(_result.error.toString()));
    }
  }
}
