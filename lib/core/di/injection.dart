import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:instituto_o_caminho/core/firebase/non_prod_firebase_options.dart';
import 'package:instituto_o_caminho/core/firebase/prod_firebase_options.dart';
import 'package:instituto_o_caminho/core/flavors/app_flavor.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/professors/domain/repositories/professors_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> bootStrap(AppFlavor flavor) async {
  getIt.registerSingleton<AppFlavor>(flavor);

  await Firebase.initializeApp(
    options: flavor.env == AppFlavorEnv.dev
        ? NonProdFirebaseOptions.currentPlatform
        : ProdFirebaseOptions.currentPlatform,
  );

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  getIt.registerFactory<ActivitiesRepository>(
    () => ActivitiesRepositoryImpl(
      authRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<ProfessorsRepository>(
    () => ProfessorsRepositoryImpl(),
  );
}
