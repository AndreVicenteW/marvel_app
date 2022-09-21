import 'package:marvel_app/app/core/states/base_bloc_state.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/usecases/get_characters_usecase.dart';
import 'package:marvel_app/app/modules/home/presenter/blocs/search/search_bloc.dart';

class SearchCharactersBlocImp extends SearchBloc<CharacterEntity> {
  final GetCharactersUseCase _getCharactersUseCase;

  SearchCharactersBlocImp(this._getCharactersUseCase) : super(InitialState());

  @override
  Future<void> call(String search,
      {int? characterId, bool pagination = false}) async {

    if(!pagination) {
      list = [];
    }

    emit(LoadingState());

    var _result = await _getCharactersUseCase(search, pagination: pagination);

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
