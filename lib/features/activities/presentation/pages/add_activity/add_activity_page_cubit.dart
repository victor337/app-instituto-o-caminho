import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/features/professors/domain/entities/professor.dart';

part 'add_activity_page_state.dart';

class AddActivityPageCubit extends Cubit<AddActivityPageState> {
  AddActivityPageCubit() : super(AddActivityPageState());

  final List<Professor> proffessorsOptions = [Professor(name: 'Raimundo', id: '1234')];

  final List<String> days = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo',
  ];

  final List<String> hours = [
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
  ];

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

  void setDates(String dates) {
    emit(state.copyWith(date: dates));
  }
}
