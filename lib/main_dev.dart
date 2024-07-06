import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/app_base.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/core/flavors/app_flavor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootStrap(AppFlavor(env: AppFlavorEnv.dev));
  runApp(const AppBase());
}
