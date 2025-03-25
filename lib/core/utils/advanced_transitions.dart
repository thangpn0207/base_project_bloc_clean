import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Advanced transitions that are aware of the navigation direction
class AdvancedTransitions {
  /// Creates a shared axis transition in either the horizontal, vertical or scaled mode
  static CustomTransitionPage<T> sharedAxisTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    SharedAxisTransitionType type = SharedAxisTransitionType.horizontal,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  /// Creates a slide transition that slides from the bottom with a fade
  static CustomTransitionPage<T> bottomToTopFadeTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  /// Creates a transition based on the navigation direction (forward/backward)
  static CustomTransitionPage<T> directionalTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    bool isForward = true,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(
          begin: isForward ? begin : -begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}

/// Implementation of SharedAxisTransition
class SharedAxisTransition extends StatelessWidget {
  const SharedAxisTransition({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
    required this.transitionType,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final SharedAxisTransitionType transitionType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    switch (transitionType) {
      case SharedAxisTransitionType.horizontal:
        return _SharedAxisHorizontal(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      case SharedAxisTransitionType.vertical:
        return _SharedAxisVertical(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      case SharedAxisTransitionType.scaled:
        return _SharedAxisScaled(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
    }
  }
}

/// Transition types for SharedAxisTransition
enum SharedAxisTransitionType {
  horizontal,
  vertical,
  scaled,
}

class _SharedAxisHorizontal extends StatelessWidget {
  const _SharedAxisHorizontal({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fadeIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    final fadeOut = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: const Interval(0, 0.7, curve: Curves.easeIn),
      ),
    );

    final slideIn = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: FadeTransition(
        opacity: fadeOut,
        child: SlideTransition(
          position: slideIn,
          child: child,
        ),
      ),
    );
  }
}

class _SharedAxisVertical extends StatelessWidget {
  const _SharedAxisVertical({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fadeIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    final fadeOut = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: const Interval(0, 0.7, curve: Curves.easeIn),
      ),
    );

    final slideIn = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: FadeTransition(
        opacity: fadeOut,
        child: SlideTransition(
          position: slideIn,
          child: child,
        ),
      ),
    );
  }
}

class _SharedAxisScaled extends StatelessWidget {
  const _SharedAxisScaled({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fadeIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    final fadeOut = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: const Interval(0, 0.7, curve: Curves.easeIn),
      ),
    );

    final scaleIn = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
    );

    return FadeTransition(
      opacity: fadeIn,
      child: FadeTransition(
        opacity: fadeOut,
        child: ScaleTransition(
          scale: scaleIn,
          child: child,
        ),
      ),
    );
  }
}
