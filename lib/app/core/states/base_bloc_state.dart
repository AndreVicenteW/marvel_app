import 'package:equatable/equatable.dart';

abstract class BaseBlocState extends Equatable {}

class InitialState extends BaseBlocState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BaseBlocState {
  @override
  List<Object> get props => [];
}

class SuccessState<T> extends BaseBlocState {
  final T data;

  SuccessState(this.data);

  @override
  List<T> get props => [data];
}

class ErrorState extends BaseBlocState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
