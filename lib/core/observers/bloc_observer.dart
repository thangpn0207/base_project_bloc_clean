import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Observer for logging BLoC lifecycle events
class ObserverBloc extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (DebugConfig.showLogs) {
      LogUtil.i('onCreate ${bloc.runtimeType}', tag: 'BlocObserver');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (DebugConfig.showLogs) {
      LogUtil.i('Event ${event.runtimeType} of ${bloc.runtimeType}',
          tag: 'BlocObserver',);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (DebugConfig.showLogs) {
      LogUtil.i('onChange ${bloc.runtimeType}, $change', tag: 'BlocObserver');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (DebugConfig.showLogs) {
      LogUtil.d(
          'Transition ${bloc.runtimeType}\n'
          'Current state: ${transition.currentState.runtimeType}\n'
          'Event: ${transition.event.runtimeType}\n'
          'Next state: ${transition.nextState.runtimeType}',
          tag: 'BlocObserver',);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Always log errors, but through our logging system that's still controlled by debug mode
    LogUtil.e('onError -- ${bloc.runtimeType}',
        tag: 'BlocObserver', error: error, stackTrace: stackTrace,);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (DebugConfig.showLogs) {
      LogUtil.i('Close -- ${bloc.runtimeType}', tag: 'BlocObserver');
    }
  }
}
