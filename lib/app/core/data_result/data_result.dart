import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String? error;

  const Failure(
    this.error,
  );

  @override
  String toString() {
    return error ?? '';
  }

  @override
  List<Object> get props => [];
}

// General failures
class GenericFailure extends Failure {
  const GenericFailure(String error) : super(error);
}

class APIFailure extends Failure {
  const APIFailure(String error) : super(error);
}

abstract class DataResult<S> extends Equatable {
  static DataResult<S> failure<S>(Failure failure) => _FailureResult(failure);

  static DataResult<S> success<S>(S data) => _SuccessResult(data);

  /// Get [error] value, returns null when the value is actually [data]
  Failure? get error => fold<Failure?>((error) => error, (data) => null);

  /// Get [data] value, returns null when the value is actually [error]
  S? get data => fold<S?>((error) => null, (data) => data);

  /// Returns `true` if the object is of the `SuccessResult` type, which means
  /// `data` will return a valid result.
  bool get isSuccess => this is _SuccessResult<S>;

  /// Returns `true` if the object is of the `FailureResult` type, which means
  /// `error` will return a valid result.
  bool get isFailure => this is _FailureResult<S>;

  /// Folds [error] and [data] into the value of one type. Only the matching
  /// function to the object type will be executed. For example, for a
  /// `SuccessResult` object only the [fnData] function will be executed.
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData);

  @override
  List<Object?> get props => [if (isSuccess) data else error];
}

class _SuccessResult<S> extends DataResult<S> {
  final S _value;

  _SuccessResult(this._value);

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnData(_value);
  }
}

class _FailureResult<S> extends DataResult<S> {
  final Failure _value;

  _FailureResult(this._value);

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) {
    return fnFailure(_value);
  }
}
