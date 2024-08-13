class AppRoutesList {
  static const onboarding = '/onboarding';
  static const home = '/';

  static const login = AppRoute(
    path: 'login',
    fullPath: '/onboarding/login',
  );
  static const register = AppRoute(
    path: 'register',
    fullPath: '/onboarding/register',
  );

  static const addActivity = AppRoute(
    path: 'add-activity',
    fullPath: '/add-activity',
  );

  static AppRouteWithId activityDetails = AppRouteWithId(
    path: 'activity-details/:id',
    buildFullPath: (id) => '/activity-details/$id',
  );

  static const punishments = AppRoute(
    path: 'punishments',
    fullPath: '/punishments',
  );

  static const profile = AppRoute(
    path: 'profile',
    fullPath: '/profile',
  );
}

class AppRoute {
  const AppRoute({
    required this.fullPath,
    required this.path,
  });

  final String fullPath;
  final String path;
}

class AppRouteWithId {
  const AppRouteWithId({
    required this.path,
    required String Function(String? id) buildFullPath,
  }) : _buildFullPath = buildFullPath;

  final String path;
  final String Function(String? id) _buildFullPath;

  String fullPath({required String? id}) => _buildFullPath(id);
}
