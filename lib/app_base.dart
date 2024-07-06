import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/routes/app_routes.dart';

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Instituto o caminho',
      theme: ThemeData(
        fontFamily: 'Calibri',
      ),
      routerConfig: AppRoutes.routes,
    );
  }
}
