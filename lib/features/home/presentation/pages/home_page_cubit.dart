import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState());

  final AuthRepository _authRepository = getIt();

  String get userName {
    return _authRepository.currentUser!.name.split(' ').first;
  }

  Future<void> refreshPage() async {
    emit(HomePageState(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    emit(HomePageState(isLoading: false));
  }
}
