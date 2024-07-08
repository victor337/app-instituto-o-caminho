import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:meta/meta.dart';

part 'activities_list_state.dart';

class ActivitiesListCubit extends Cubit<ActivitiesListState> {
  ActivitiesListCubit() : super(ActivitiesListLoading()) {
    init();
  }

  final ActivitiesRepository _activitiesRepository = getIt();

  Future<void> init() async {
    final activitiesResult = await _activitiesRepository.getActivities();

    activitiesResult.fold(
      (error) {
        emit(ActivitiesListError());
      },
      (activities) {
        emit(ActivitiesListDone(activities: activities));
      },
    );
  }
}
