import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imag_in/core/router/routes.dart';
import 'package:imag_in/core/screens/app_state_screen.dart';
import 'package:imag_in/core/services/app_status_provider.dart';
import 'package:imag_in/core/utils/enums/app_state.dart';
import 'package:imag_in/features/authentication/screens/authentication_screen.dart';
import 'package:imag_in/features/gallery/gallery_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  late AppStatusProvider appStatusProvider;
  void updateAppStatusProvider(AppStatusProvider provider) =>
      appStatusProvider = provider;

  GoRouter get router => _goRouter;
  late final _goRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: appStatusProvider,
    debugLogDiagnostics: true,
    initialLocation: '/gallery',
    redirect: (context, state) {
      final isInternetConnected = appStatusProvider.isInternetConnected;
      final isLoading = appStatusProvider.isLoading;
      final isLoggedIn = appStatusProvider.isLoggedIn;
      final onNoInternetScreen =
          state.matchedLocation == '/${Routes.noInternet.route}';
      final onLoadingScreen =
          state.matchedLocation == '/${Routes.loading.route}';
      final onAuthenticationScreen =
          state.matchedLocation == '/${Routes.authentication.route}';

      if (!isInternetConnected) {
        return '/${Routes.noInternet.route}';
      }

      if (isLoading) {
        return '/${Routes.loading.route}';
      }

      if (!isLoggedIn) {
        return '/${Routes.authentication.route}';
      }

      if (isLoggedIn && onNoInternetScreen) {
        return '/${Routes.gallery.route}';
      }

      if (isLoggedIn && onLoadingScreen) {
        return '/${Routes.gallery.route}';
      }

      if (isLoggedIn && onAuthenticationScreen) {
        return '/${Routes.gallery.route}';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/${Routes.noInternet.route}',
        name: Routes.noInternet.route,
        builder: (context, state) => const AppStateScreen(AppState.noInternet),
      ),
      GoRoute(
        path: '/${Routes.loading.route}',
        name: Routes.loading.route,
        builder: (context, state) => const AppStateScreen(AppState.loading),
      ),
      GoRoute(
        path: '/${Routes.authentication.route}',
        name: Routes.authentication.route,
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: '/${Routes.gallery.route}',
        name: Routes.gallery.route,
        builder: (context, state) => const GalleryScreen(),
      ),
      GoRoute(
        path: '/${Routes.photo.route}',
        name: Routes.photo.route,
        builder: (context, state) => const Placeholder(),
      ),
    ],
  );
}
