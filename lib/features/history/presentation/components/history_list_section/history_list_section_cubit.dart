import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/history/domain/entities/history.dart';
import 'package:instituto_o_caminho/features/history/domain/repositories/history_repository.dart';
import 'package:meta/meta.dart';

part 'history_list_section_state.dart';

class HistoryListSectionCubit extends Cubit<HistoryListSectionState> {
  HistoryListSectionCubit() : super(HistoryListSectionLoading()) {
    init();
  }

  final HistoryRepository _historyRepository = getIt();

  Future<void> init() async {
    emit(HistoryListSectionLoading());

    final result = await _historyRepository.getHistory();

    result.fold(
      (error) {
        emit(HistoryListSectionError());
      },
      (history) async {
        emit(HistoryListSectionDone(history: history));
      },
    );
  }
}
