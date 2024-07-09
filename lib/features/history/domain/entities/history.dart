import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  History({
    required this.wasPresent,
    required this.date,
    required this.activityTitle,
    required this.professorName,
  });

  Map<String, dynamic> toMap() {
    return {
      'wasPresent': wasPresent,
      'date': date,
      'activityTitle': activityTitle,
      'professorName': professorName,
    };
  }

  static History fromJson(Map<String, dynamic> map) {
    return History(
      wasPresent: map['wasPresent'] as bool,
      date: (map['date'] as Timestamp).toDate(),
      professorName: map['professorName'] as String,
      activityTitle: map['activityTitle'] as String,
    );
  }

  final bool wasPresent;
  final DateTime date;
  final String professorName;
  final String activityTitle;
}
