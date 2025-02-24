import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instituto_o_caminho/core/routes/app_routes_list.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/activity_details/activity_details_page.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/add_activity/add_activity_page.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/cancel_activity/cancel_activity_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/login/login_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page.dart';
import 'package:instituto_o_caminho/features/home/presentation/pages/home_page.dart';
import 'package:instituto_o_caminho/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:instituto_o_caminho/features/profile/presentation/pages/edit_profile/edit_profile_page.dart';

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
        routes: [
          GoRoute(
            path: AppRoutesList.addActivity.path,
            pageBuilder: (context, state) {
              return CustomPage(
                state: state,
                child: const AddActivityPage(),
              );
            },
          ),
          GoRoute(
            path: AppRoutesList.activityDetails.path,
            pageBuilder: (context, state) {
              final activityId = state.pathParameters['id'] as String;

              return CustomPage(
                state: state,
                child: ActivityDetailsPage(activityId: activityId),
              );
            },
          ),
          GoRoute(
            path: AppRoutesList.cancelActivity.path,
            pageBuilder: (context, state) {
              return CustomPage(
                state: state,
                child: const CancelActivityPage(),
              );
            },
          ),
          GoRoute(
            path: AppRoutesList.profile.path,
            pageBuilder: (context, state) {
              return CustomPage(
                state: state,
                child: const EditProfilePage(),
              );
            },
          )
        ],
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
