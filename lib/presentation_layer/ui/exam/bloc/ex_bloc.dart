import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ex_event.dart';
part 'ex_state.dart';
part 'ex_bloc.freezed.dart';

class ExBloc extends Bloc<ExEvent, ExState> {
  ExBloc() : super(const ExState.initial()) {
    on<ExEvent.plus>();
    void _onPlus(ExEvent event, Emitter<ExState> state) {}
  }
}
