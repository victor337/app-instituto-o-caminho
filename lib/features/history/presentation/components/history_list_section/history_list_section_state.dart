part of 'history_list_section_cubit.dart';

@immutable
abstract class HistoryListSectionState {}

class HistoryListSectionLoading extends HistoryListSectionState {}

class HistoryListSectionError extends HistoryListSectionState {}

class HistoryListSectionDone extends HistoryListSectionState {
  HistoryListSectionDone({
    required this.history,
  });

  final List<History> history;
}
