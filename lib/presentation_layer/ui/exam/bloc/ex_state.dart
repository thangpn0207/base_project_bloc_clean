part of 'ex_bloc.dart';

@freezed
class ExState with _$ExState {
  const factory ExState.initial() = _Initial;

  factory ExState({
    required final int age,
  }) = _ExState;
}
