import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:tech_task/core/api/api.dart';
// import 'package:tech_task/data_error.dart';

typedef OnSuccess<T, R> = R Function(T data);
typedef OnError<E, R> = R Function(RequestFailure error);

/// Null-safe implementation of Result that is base simplified on Haskel's
/// Either
@sealed
@immutable
abstract class Result<T, E> extends Equatable {
  const Result();

  /// Allows safely matching different states of the result
  ///
  /// If anything throws in [onSuccess] or [onError] then it will NOT be
  /// caught
  R match<R>({
    required OnSuccess<T, R> onSuccess,
    required OnError<E, R> onError,
  });
}

/// [Result] that calls [onSuccess] when matched.
class SuccessResult<T, E> extends Result<T, E> {
  final T data;

  /// For type `void` [data] must be specified as `null`.
  const SuccessResult({required this.data});

  @override
  R match<R>({
    required OnSuccess<T, R> onSuccess,
    required OnError<E, R> onError,
  }) =>
      onSuccess(data);

  @override
  List<Object?> get props => [data];
}

/// [Result] that calls [onError] when matched.
class ErrorResult<T, E> extends Result<T, E> {
  final RequestFailure error;

  const ErrorResult({required this.error});

  @override
  R match<R>({
    required OnSuccess<T, R> onSuccess,
    required OnError<E, R> onError,
  }) =>
      onError(error);

  @override
  List<Object> get props => [error];
}
