import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/core/extensions/string_extension.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/profile/presentation/pages/edit_profile/edit_profile_page_view.dart';

part 'edit_profile_page_state.dart';

class EditProfilePageCubit extends Cubit<EditProfilePageState> {
  EditProfilePageCubit({
    required this.view,
  }) : super(EditProfilePageState()) {
    init();
  }

  EditProfilePageView? view;

  final AuthRepository _authRepository = getIt();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final user = _authRepository.currentUser;

    emit(state.copyWith(
      name: user!.name,
      phone: user.phone,
      image: user.image,
      isLoading: false,
    ));
  }

  void setName(String value) {
    emit(state.copyWith(name: value));
  }

  void setPhone(String value) {
    emit(state.copyWith(phone: value));
  }

  Future<void> updateProfile() async {}

  void dispose() {
    view = null;
  }
}
