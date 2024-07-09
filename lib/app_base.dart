import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instituto_o_caminho/core/routes/app_routes.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp.router(
      title: 'Instituto o caminho',
      theme: ThemeData(
        fontFamily: 'Calibri',
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: constLight),
        ),
      ),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      routerConfig: AppRoutes.routes,
    );
  }
}
