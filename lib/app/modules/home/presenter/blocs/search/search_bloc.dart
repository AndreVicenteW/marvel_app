import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/core/states/base_bloc_state.dart';

abstract class SearchBloc<T> extends Cubit<BaseBlocState> {
  SearchBloc(InitialState initialState) : super(initialState);
  List<T> list = [];

  Future<void> call(String search, {int? characterId, bool pagination = false});
}