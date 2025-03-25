import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObserverBloc extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (DebugConfig.showLogs) {
      logUtil.info('onCreate ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (DebugConfig.showLogs) {
      logUtil.info('Event ${event.runtimeType} of ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (DebugConfig.showLogs) {
      logUtil.info('onChange ${bloc.runtimeType}, $change');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (DebugConfig.showLogs) {
      logUtil.verbose('Transition ${bloc.runtimeType}\n'
          'Current state: ${transition.currentState.runtimeType}\n'
          'Event: ${transition.event.runtimeType}\n'
          'Next state: ${transition.nextState.runtimeType}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Always log errors, but through our logging system that's still controlled by debug mode
    logUtil.error('onError -- ${bloc.runtimeType}', error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (DebugConfig.showLogs) {
      logUtil.info('Close -- ${bloc.runtimeType}');
    }
  }
}
