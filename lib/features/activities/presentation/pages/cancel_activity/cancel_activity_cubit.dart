import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/cancel_activity/cancel_activity_state.dart';

class CancelActivityCubit extends Cubit<CancelActivityState> {
  CancelActivityCubit() : super(const CancelActivityState()) {
    init();
  }

  final ActivitiesRepository _activitiesRepository = getIt();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final result = await _activitiesRepository.getActivities();

    result.when(
      (success) {
        emit(state.copyWith(isLoading: false, activities: success));
      },
      (fail) {},
    );
  }

  void setActivity(Activity value) {
    emit(state.copyWith(selectActivity: value));
  }

  void setDate(DateTime value) {
    emit(state.copyWith(date: value));
  }

  void setReason(String value) {
    emit(state.copyWith(reason: value));
  }

  Future<void> sendForm() async {}
}
