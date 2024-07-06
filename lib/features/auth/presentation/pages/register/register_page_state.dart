part of 'register_page_cubit.dart';

enum RegisterPageIndex { name, phone, email, pass }

class RegisterPageState {
  RegisterPageState({
    this.name,
    this.phone,
    this.email,
    this.pass,
    this.index,
    this.isLoading = false,
  });

  RegisterPageState copyWith({
    String? name,
    String? phone,
    String? email,
    String? pass,
    RegisterPageIndex? index,
    bool? isLoading,
  }) {
    return RegisterPageState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      pass: pass ?? this.pass,
      index: index ?? this.index,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final String? name;
  final String? phone;
  final String? email;
  final String? pass;
  final RegisterPageIndex? index;
  final bool isLoading;

  bool get currentFormIsValid {
    switch (index) {
      case null:
        return false;
      case RegisterPageIndex.name:
        return nameIsValid;
      case RegisterPageIndex.phone:
        return phoneIsValid;
      case RegisterPageIndex.email:
        return emailIsValid;
      case RegisterPageIndex.pass:
        return false;
    }
  }

  bool get nameIsValid {
    return name != null && name!.trim().split(' ').length >= 2;
  }

  bool get phoneIsValid {
    return phone != null && phone!.trim().onlyNumbers.length == 11;
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
