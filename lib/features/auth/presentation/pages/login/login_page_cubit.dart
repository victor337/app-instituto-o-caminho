import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/results/login_result.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/login/login_page_view.dart';

part 'login_page_state.dart';

enum LoginPageIndex { email, pass }

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit({
    required this.pageController,
    required this.view,
  }) : super(LoginPageState(index: LoginPageIndex.email));

  final PageController pageController;
  LoginPageView? view;

  final AuthRepository _authRepository = getIt();

  void floatButtonPressed() {
    if (!state.currentFormIsValid) {
      return;
    }

    switch (state.index) {
      case LoginPageIndex.email:
        animateToPage(LoginPageIndex.pass.index);
        break;
      case LoginPageIndex.pass:
        break;
    }
  }

  void animateToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    emit(state.copyWith(index: LoginPageIndex.values[index]));
  }

  void backPressed() {
    switch (state.index) {
      case LoginPageIndex.email:
        view?.popPage();
        break;
      case LoginPageIndex.pass:
        animateToPage(LoginPageIndex.email.index);
        break;
    }
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

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.login(state.email!, state.pass!);

    result.fold(
      (error) {
        switch (error) {
          case LoginResult.incorrectPass:
            view?.errorToLogin(
              'Senha incorreta',
              'A senha inserida está incorreta',
            );
            break;
          case LoginResult.noUser:
            view?.errorToLogin(
              'Usuário não encontrado',
              'Não existe um usuário cadastrado com o e-mail infomado',
            );
            break;
          case LoginResult.failed:
            view?.errorToLogin(
              'Ops, tivemos um problema',
              'Tivemos um problema ao realizar o login, tente novamente mais tarde',
            );
            break;
        }
      },
      (r) {
        view?.successToLogin();
      },
    );

    emit(state.copyWith(isLoading: false));
  }
}
