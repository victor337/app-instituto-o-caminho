import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/core/extensions/string_extension.dart';
import 'package:instituto_o_caminho/features/auth/domain/entities/register_user_data.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/results/register_user_result.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_view.dart';

part 'register_page_state.dart';

class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit({
    required this.pageController,
    required this.view,
  }) : super(RegisterPageState(index: RegisterPageIndex.name));

  final PageController pageController;
  RegisterPageView? view;

  final AuthRepository _authRepository = getIt();

  void floatButtonPressed() {
    if (!state.currentFormIsValid) {
      return;
    }

    switch (state.index) {
      case null:
      case RegisterPageIndex.pass:
        break;
      case RegisterPageIndex.name:
        animateToPage(RegisterPageIndex.phone.index);
        break;
      case RegisterPageIndex.phone:
        animateToPage(RegisterPageIndex.email.index);
        break;
      case RegisterPageIndex.email:
        animateToPage(RegisterPageIndex.pass.index);
        break;
    }
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    emit(state.copyWith(index: RegisterPageIndex.values[index]));
  }

  void backPressed() {
    switch (state.index) {
      case null:
        break;
      case RegisterPageIndex.name:
        view?.popPage();
        break;
      case RegisterPageIndex.phone:
        animateToPage(RegisterPageIndex.name.index);
        break;
      case RegisterPageIndex.email:
        animateToPage(RegisterPageIndex.phone.index);
        break;
      case RegisterPageIndex.pass:
        animateToPage(RegisterPageIndex.email.index);
        break;
    }
  }

  void setName(String value) {
    emit(state.copyWith(name: value.trim()));
  }

  void setPhone(String value) {
    emit(state.copyWith(phone: value.trim()));
  }

  void setEmail(String value) {
    emit(state.copyWith(email: value.trim()));
  }

  void setPass(String value) {
    emit(state.copyWith(pass: value));
  }

  void dispose() {
    view = null;
  }

  Future<void> register() async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.registerUser(RegisterUserData(
      name: state.name!,
      email: state.email!,
      phone: state.phone!,
      pass: state.pass!,
    ));

    result.fold(
      (error) {
        switch (error) {
          case RegisterUserResult.emailAlreadyUse:
            view?.errorToRegister('Este e-mail já está sendo usado');
            break;
          case RegisterUserResult.failed:
            view?.errorToRegister(
              'Tivemos um problema ao realizar o cadastro, tente novamente mais tarde',
            );
            break;
        }
      },
      (r) {
        view?.successToRegister();
      },
    );

    emit(state.copyWith(isLoading: false));
  }
}
