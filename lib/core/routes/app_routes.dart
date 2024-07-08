import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instituto_o_caminho/core/routes/app_routes_list.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/login/login_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page.dart';
import 'package:instituto_o_caminho/features/home/presentation/pages/home_page.dart';
import 'package:instituto_o_caminho/features/onboarding/presentation/pages/onboarding_page.dart';

class AppRoutes {
  static final protectedRoutes = [
    RegExp(r"\/profile\/.*"),
    RegExp(r"\/domains\/.*"),
  ];

  static final routes = GoRouter(
    redirect: (context, state) async {
      return null;
    },
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: AppRoutesList.home,
        pageBuilder: (context, state) {
          return CustomPage(
            state: state,
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutesList.onboarding,
        routes: [
          GoRoute(
            path: AppRoutesList.register.path,
            pageBuilder: (context, state) {
              return CustomPage(
                state: state,
                child: const RegisterPage(),
              );
            },
          ),
          GoRoute(
            path: AppRoutesList.login.path,
            pageBuilder: (context, state) {
              return CustomPage(
                state: state,
                child: const LoginPage(),
              );
            },
          )
        ],
        pageBuilder: (context, state) {
          return CustomPage(
            state: state,
            child: const OnboardingPage(),
          );
        },
      ),
    ],
  );
}

class CustomPage extends MaterialPage {
  CustomPage({
    required super.child,
    required GoRouterState state,
  }) : super(
          name: state.fullPath,
          arguments: {
            ...state.pathParameters,
            ...state.uri.queryParameters,
          },
        );
}
