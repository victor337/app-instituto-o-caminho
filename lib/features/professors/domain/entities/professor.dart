class Professor {
  Professor({required this.name, required this.id});

  static Professor fromJson(Map<String, dynamic> map) {
    return Professor(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  final String name;
  final String id;
}
