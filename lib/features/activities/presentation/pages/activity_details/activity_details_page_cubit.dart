import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';

part 'activity_details_page_state.dart';

class ActivityDetailsPageCubit extends Cubit<ActivityDetailsPageState> {
  ActivityDetailsPageCubit({
    required this.activityId,
  }) : super(ActivityDetailsPageState(isLoading: true)) {
    init();
  }

  final String activityId;

  final ActivitiesRepository _activitiesRepository = getIt();
  final AuthRepository _authRepository = getIt();

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));

    final results = await Future.wait([
      _activitiesRepository.getActivityById(activityId),
      _activitiesRepository.getSubscribers(activityId),
      _activitiesRepository.getIfIsWaitList(activityId),
    ]);

    if (results.any((e) => e.isLeft())) {
      return;
    }

    results[0].fold(
      (_) => null,
      (activity) => results[1].fold(
        (error) => null,
        (subscribers) => results[2].fold(
          (_) => null,
          (isWaitList) {
            final isSubscribe = (subscribers as List<String>).any(
              (e) => e == _authRepository.currentUser!.id,
            );

            print(subscribers);

            emit(state.copyWith(
              isLoading: false,
              isSubscribe: isSubscribe,
              isWaitList: isWaitList as bool,
              activity: activity as Activity,
              hasVacancies: subscribers.length < activity.vacancies,
            ));
          },
        ),
      ),
    );
  }

  VoidCallback get buttonPressed {
    if (state.isSubscribe) {
      return cancelSubscription;
    } else if (state.isWaitList) {
      return cancelWaitList;
    } else {
      if (state.hasVacancies) {
        return subscribe;
      } else {
        return joinWaitList;
      }
    }
  }

  Future<void> cancelSubscription() async {}

  Future<void> cancelWaitList() async {}

  Future<void> subscribe() async {}

  Future<void> joinWaitList() async {}
}
