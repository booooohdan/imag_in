import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imag_in/core/router/app_router.dart';
import 'package:imag_in/core/services/app_status_provider.dart';
import 'package:imag_in/core/styles/app_theme.dart';
import 'package:imag_in/features/authentication/services/auth_provider.dart';
import 'package:imag_in/features/gallery/services/gallery_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      //* Init allowed orientations and system UI
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AppStatusProvider()),
            ChangeNotifierProvider(create: (_) => GalleryProvider()),
            ChangeNotifierProxyProvider<AppStatusProvider, AuthProvider>(
              create: (_) => AuthProvider(),
              update: (_, appStatusProvider, authService) =>
                  authService!..updateAppStatusProvider(appStatusProvider),
            ),
            ProxyProvider<AppStatusProvider, AppRouter>(
              create: (_) => AppRouter(),
              update: (context, appStatusProvider, appRouter) =>
                  appRouter!..updateAppStatusProvider(appStatusProvider),
            ),
          ],
          child: Builder(
            builder: (context) {
              final goRouter = context.read<AppRouter>().router;

              return MaterialApp.router(
                routerConfig: goRouter,
                theme: AppTheme.theme,
                debugShowCheckedModeBanner: false,
                builder: (context, appWidget) => appWidget!,
              );
            },
          ),
        ),
      );
    },
    (error, stackTrace) {
      // Error handling logic, e.g. Sentry
    },
  );
  FlutterError.onError = (details) {
    if (!details.silent) {
      // Error handling logic, e.g. Sentry
    }
  };
}
