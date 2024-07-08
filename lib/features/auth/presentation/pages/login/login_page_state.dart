part of 'login_page_cubit.dart';

class LoginPageState {
  LoginPageState({
    required this.index,
    this.email,
    this.pass,
    this.isLoading = false,
  });

  LoginPageState copyWith({
    LoginPageIndex? index,
    String? email,
    String? pass,
    bool? isLoading,
  }) {
    return LoginPageState(
      index: index ?? this.index,
      email: email ?? this.email,
      pass: pass ?? this.pass,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final LoginPageIndex index;
  final String? email;
  final String? pass;
  final bool isLoading;

  bool get currentFormIsValid {
    switch (index) {
      case LoginPageIndex.email:
        return emailIsValid;
      case LoginPageIndex.pass:
        return false;
    }
  }

  bool get emailIsValid {
    if (email == null) return false;

    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!.trim());
  }

  bool get passIsValid {
    return pass != null && pass!.length >= 6;
  }
}
