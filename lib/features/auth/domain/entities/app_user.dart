class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    this.isAdmin = false,
  });

  static AppUser fromJson(Map<String, dynamic> data) {
    return AppUser(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      image: data['image'] ??
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }

  final String id;
  final String name;
  final String email;
  final String phone;
  String image;
  bool isAdmin;
}
