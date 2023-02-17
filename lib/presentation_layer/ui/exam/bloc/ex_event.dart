part of 'ex_bloc.dart';

@freezed
class ExEvent with _$ExEvent {
  const factory ExEvent.started() = _Started;
  const factory ExEvent.plus(int value) = _Plus;
}
