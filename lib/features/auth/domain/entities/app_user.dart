class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  static AppUser fromJson(Map<String, dynamic> data) {
    return AppUser(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
    );
  }

  final String id;
  final String name;
  final String email;
  final String phone;
}
