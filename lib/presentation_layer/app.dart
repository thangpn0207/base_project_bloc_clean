import 'package:base_project_bloc/core/locale/generated/l10n.dart';
import 'package:base_project_bloc/presentation_layer/core_app/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:base_project_bloc/core/theme/cubit/theme_cubit.dart';
import 'package:base_project_bloc/core/di/injection.dart';
import 'package:base_project_bloc/core/theme/app_theme.dart';
import 'package:base_project_bloc/core/utils/deep_link_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
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
      // Khi màn hình được mở lại, kiểm tra trạng thái của bàn phím
      final currentFocus = FocusManager.instance.primaryFocus;
      if (currentFocus != null && currentFocus.hasFocus) {
        // Nếu bàn phím đang được hiển thị, unfocus nó
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
    List<BlocProvider> getProviders() => [
          BlocProvider(create: (context) => getIt<ThemeCubit>()),
        ];
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // iPhone X design size, change as needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: getProviders(),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                themeMode: themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouter.router,
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
                      Breakpoint(start: 1921, end: double.infinity, name: '4K'),
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
          ),
        );
      },
    );
  }
}
