import 'package:base_project_bloc/core/config/dependency/injection.dart';
import 'package:base_project_bloc/core/locale/generated/l10n.dart';
import 'package:base_project_bloc/presentation_layer/core_app/locale/cubit/locale_cubit.dart';
import 'package:base_project_bloc/presentation_layer/core_app/routes/app_router.dart';
import 'package:base_project_bloc/presentation_layer/theme/app_theme.dart';
import 'package:base_project_bloc/presentation_layer/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:base_project_bloc/core/utils/deep_link_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Store cubit instances directly
  late final ThemeCubit _themeCubit;
  late final LocaleCubit _localeCubit;

  @override
  void initState() {
    super.initState();
    // Initialize cubits directly from dependency injection
    _themeCubit = getIt<ThemeCubit>();
    _localeCubit = getIt<LocaleCubit>();
    WidgetsBinding.instance.addObserver(this);
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    await DeepLinkHandler.initDeepLinks();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // When the screen is reopened, check the keyboard state
      final currentFocus = FocusManager.instance.primaryFocus;
      if (currentFocus != null && currentFocus.hasFocus) {
        // If the keyboard is displayed, unfocus it
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // iPhone X design size, change as needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // Create a list of providers for better scalability
        final List<BlocProvider> providers = [
          BlocProvider<ThemeCubit>.value(value: _themeCubit),
          BlocProvider<LocaleCubit>.value(value: _localeCubit),
          // Add more providers here in the future as needed
        ];

        return MultiBlocProvider(
          providers: providers,
          child: BlocBuilder<LocaleCubit, Locale>(
            bloc: _localeCubit,
            builder: (context, locale) {
              return BlocBuilder<ThemeCubit, ThemeMode>(
                bloc: _themeCubit,
                builder: (context, themeMode) {
                  return MaterialApp.router(
                    themeMode: themeMode,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    debugShowCheckedModeBanner: false,
                    routerConfig: AppRouter.router,
                    locale: locale,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    builder: (context, child) {
                      // Wrap with ResponsiveFramework for web responsiveness
                      child = ResponsiveBreakpoints.builder(
                        child: child!,
                        breakpoints: const [
                          Breakpoint(start: 0, end: 450, name: MOBILE),
                          Breakpoint(start: 451, end: 800, name: TABLET),
                          Breakpoint(start: 801, end: 1920, name: DESKTOP),
                          Breakpoint(
                              start: 1921, end: double.infinity, name: '4K',),
                        ],
                      );

                      return GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: SafeArea(
                          bottom: false,
                          child: Scaffold(
                            body: child,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
