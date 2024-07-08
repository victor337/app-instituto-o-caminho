class Activity {
  Activity({
    required this.title,
    required this.description,
    required this.professor,
    required this.address,
    required this.duration,
    required this.date,
  });

  static Activity fromJson(Map<String, dynamic> data) {
    return Activity(
      title: data['title'] as String,
      description: data['description'] as String,
      professor: data['professor'] as String,
      address: data['address'] as String,
      duration: data['duration'] as String,
      date: data['date'] as String,
    );
  }

  final String title;
  final String description;
  final String professor;
  final String address;
  final String duration;
  final String date;
}
