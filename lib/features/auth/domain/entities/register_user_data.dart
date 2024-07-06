class RegisterUserData {
  RegisterUserData({
    required this.name,
    required this.email,
    required this.phone,
    required this.pass,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "pass": pass,
    };
  }

  final String name;
  final String email;
  final String phone;
  final String pass;
}
