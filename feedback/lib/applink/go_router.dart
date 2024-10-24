import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:feedback/home_screen.dart';
import 'package:feedback/applink/profile_screen.dart';
import 'package:feedback/applink/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/profile/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String profileId = state.pathParameters['id'] ?? 'Unknown';
        return ProfileScreen(profileId: profileId);
      },
    ),
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
  ],
);
