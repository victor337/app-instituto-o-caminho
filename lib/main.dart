import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/app_base.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/core/flavors/app_flavor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootStrap(AppFlavor(env: AppFlavorEnv.prod));

  runApp(const AppBase());
}
