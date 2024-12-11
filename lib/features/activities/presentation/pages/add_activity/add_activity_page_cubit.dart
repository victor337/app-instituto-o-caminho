import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:instituto_o_caminho/features/professors/domain/entities/professor.dart';
import 'package:instituto_o_caminho/features/professors/domain/repositories/professors_repository.dart';
import 'package:instituto_o_caminho/features/utils/const_dates.dart';
import 'package:instituto_o_caminho/features/utils/const_hours.dart';

part 'add_activity_page_state.dart';

class AddActivityPageCubit extends Cubit<AddActivityPageState> {
  AddActivityPageCubit() : super(AddActivityPageState()) {
    init();
  }

  final ProfessorsRepository _professorsRepository = getIt();
  final ActivitiesRepository _activitiesRepository = getIt();

  List<String> get hours => constHours;
  List<String> get days => constDays;

  final List<Professor> professorsOptions = [];

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final result = await _professorsRepository.getProfessors();

    result.fold((error) {}, (professors) {
      professorsOptions.addAll(professors);
    });
    emit(state.copyWith(isLoading: false));
  }

  void setTitle(String value) {
    emit(state.copyWith(title: value));
  }

  void setDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void setProfessor(Professor value) {
    emit(state.copyWith(professor: value));
  }

  void setVacancies(String vacancies) {
    emit(state.copyWith(vacancies: int.parse(vacancies)));
  }

  void setDates(String date) {
    final currentDates = state.dates ?? [];
    if (currentDates.contains(date)) {
      currentDates.remove(date);
    } else {
      currentDates.add(date);
    }
    emit(state.copyWith(dates: currentDates));
  }

  void setHour(String hour) {
    emit(state.copyWith(hour: hour));
  }

  Future<void> sendForm() async {
    if(state.hasErrors){
      return emit(state.copyWith(showErrors: true));
    }

    final result = await _activitiesRepository.getActivities();
  }
}
