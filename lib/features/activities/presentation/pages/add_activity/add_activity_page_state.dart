part of 'add_activity_page_cubit.dart';

class AddActivityPageState {
  AddActivityPageState({
    this.title,
    this.description,
    this.professor,
    this.images,
    this.date,
    this.duration,
    this.vacancies,
    this.isLoading,
    this.buttonIsLoading,
  });

  AddActivityPageState copyWith({
    bool? isLoading,
    bool? buttonIsLoading,
    String? title,
    String? description,
    Professor? professor,
    List<String>? images,
    String? date,
    String? duration,
    int? vacancies,
  }) {
    return AddActivityPageState(
      title: title ?? this.title,
      description: description ?? this.description,
      professor: professor ?? this.professor,
      images: images ?? this.images,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      vacancies: vacancies ?? this.vacancies,
      isLoading: isLoading ?? this.isLoading,
      buttonIsLoading: buttonIsLoading ?? this.buttonIsLoading,
    );
  }

  final bool? isLoading;
  final bool? buttonIsLoading;
  final String? title;
  final String? description;
  final Professor? professor;
  final List<String>? images;
  final String? date;
  final String? duration;
  final int? vacancies;
}
