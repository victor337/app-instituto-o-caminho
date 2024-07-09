import 'package:cloud_firestore/cloud_firestore.dart';

class Punishment {
  Punishment({
    required this.title,
    required this.description,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'userId': userId,
    };
  }

  static Punishment fromJson(Map<String, dynamic> map) {
    return Punishment(
      title: map['title'] as String,
      description: map['description'] as String,
      date: (map['date'] as Timestamp).toDate(),
      userId: map['userId'] as String,
    );
  }

  final String title;
  final String description;
  final DateTime date;
  final String userId;
}
