class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  static AppUser fromJson(Map<String, dynamic> data, String id) {
    return AppUser(
      id: id,
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
