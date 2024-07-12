import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/auth/domain/entities/app_user.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';

part 'app_menu_state.dart';

class AppMenuCubit extends Cubit<AppMenuState> {
  AppMenuCubit() : super(AppMenuState());

  final AuthRepository _authRepository = getIt();

  AppUser get user => _authRepository.currentUser!;

  void exitToApp() {
    _authRepository.logout();
  }
}
