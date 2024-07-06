class AppFlavor {
  AppFlavor({required this.env});
  final AppFlavorEnv env;
}

enum AppFlavorEnv { dev, prod }
