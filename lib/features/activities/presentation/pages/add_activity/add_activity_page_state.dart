part of 'add_activity_page_cubit.dart';

class AddActivityPageState {
  AddActivityPageState({
    this.title,
    this.description,
    this.professor,
    this.images,
    this.dates,
    this.hour,
    this.vacancies,
    this.isLoading = false,
    this.buttonIsLoading,
    this.showErrors = false,
  });

  AddActivityPageState copyWith({
    bool? isLoading,
    bool? buttonIsLoading,
    String? title,
    String? description,
    Professor? professor,
    List<String>? images,
    List<String>? dates,
    String? hour,
    int? vacancies,
    bool? showErrors,
  }) {
    return AddActivityPageState(
      title: title ?? this.title,
      description: description ?? this.description,
      professor: professor ?? this.professor,
      images: images ?? this.images,
      dates: dates ?? this.dates,
      hour: hour ?? this.hour,
      vacancies: vacancies ?? this.vacancies,
      isLoading: isLoading ?? this.isLoading,
      buttonIsLoading: buttonIsLoading ?? this.buttonIsLoading,
      showErrors: showErrors ?? this.showErrors,
    );
  }

  final bool isLoading;
  final bool? buttonIsLoading;
  final String? title;
  final String? description;
  final Professor? professor;
  final List<String>? images;
  final List<String>? dates;
  final String? hour;
  final int? vacancies;
  final bool showErrors;

  bool get hasErrors {
    return false;
  }
}
