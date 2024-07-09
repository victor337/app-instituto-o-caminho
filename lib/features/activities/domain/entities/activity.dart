class Activity {
  Activity({
    required this.title,
    required this.description,
    required this.professor,
    required this.address,
    required this.duration,
    required this.date,
    required this.id,
    required this.images,
    required this.vacancies,
  });

  static Activity fromJson(Map<String, dynamic> data) {
    return Activity(
        title: data['title'] as String,
        description: data['description'] as String,
        professor: data['professor'] as String,
        address: data['address'] as String,
        duration: data['duration'] as String,
        date: data['date'] as String,
        id: data['id'] as String,
        vacancies: data['vacancies'] as int,
        images: [
          for (final photo in data['images']) photo as String,
        ]);
  }

  final String title;
  final String description;
  final String professor;
  final String address;
  final String duration;
  final String date;
  final String id;
  final List<String> images;
  final int vacancies;
}
