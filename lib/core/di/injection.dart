import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/core/firebase/non_prod_firebase_options.dart';
import 'package:instituto_o_caminho/core/firebase/prod_firebase_options.dart';
import 'package:instituto_o_caminho/core/flavors/app_flavor.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/history/domain/repositories/history_repository.dart';
import 'package:instituto_o_caminho/features/professors/domain/repositories/professors_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> bootStrap(AppFlavor flavor) async {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  getIt.registerSingleton<AppFlavor>(flavor);

  await Firebase.initializeApp(
    options: flavor.env == AppFlavorEnv.dev
        ? NonProdFirebaseOptions.currentPlatform
        : ProdFirebaseOptions.currentPlatform,
  );

  getIt.registerSingleton<LoggerRepository>(LoggerRepositoryImpl());

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(
    loggerRepository: getIt(),
  ));

  getIt.registerFactory<ActivitiesRepository>(
    () => ActivitiesRepositoryImpl(
      authRepository: getIt<AuthRepository>(),
      loggerRepository: getIt(),
    ),
  );

  getIt.registerFactory<ProfessorsRepository>(
    () => ProfessorsRepositoryImpl(
      loggerRepository: getIt(),
    ),
  );

  getIt.registerFactory<HistoryRepository>(
    () => HistoryRepositoryImpl(
      authRepository: getIt(),
      loggerRepository: getIt(),
    ),
  );
}
