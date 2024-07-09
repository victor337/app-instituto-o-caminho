import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/repositories/activities_repository.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/subscribe_activity_result.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/activity_details/activity_details_page_view.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/professors/domain/entities/professor.dart';
import 'package:instituto_o_caminho/features/professors/domain/repositories/professors_repository.dart';

part 'activity_details_page_state.dart';

class ActivityDetailsPageCubit extends Cubit<ActivityDetailsPageState> {
  ActivityDetailsPageCubit({
    required this.activityId,
    required this.view,
  }) : super(ActivityDetailsPageState(isLoading: true)) {
    init();
  }

  final String activityId;
  ActivityDetailsPageView? view;

  final ActivitiesRepository _activitiesRepository = getIt();
  final AuthRepository _authRepository = getIt();
  final ProfessorsRepository _professorsRepository = getIt();

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
          (isWaitList) async {
            final professorResult =
                await _professorsRepository.getProfessorDataById(
              (activity as Activity).professor,
            );

            professorResult.fold(
              (error) {},
              (professor) {
                final isSubscribe = (subscribers as List<String>).any(
                  (e) => e == _authRepository.currentUser!.id,
                );

                emit(state.copyWith(
                  isLoading: false,
                  isSubscribe: isSubscribe,
                  isWaitList: isWaitList as bool,
                  activity: activity,
                  hasVacancies: subscribers.length < activity.vacancies,
                  professor: professor,
                ));
              },
            );
          },
        ),
      ),
    );
  }

  VoidCallback get buttonPressed {
    if (state.isSubscribe) {
      return cancelSubscription;
    } else if (state.isWaitList) {
      return removeFromWaitList;
    } else {
      if (state.hasVacancies) {
        return subscribe;
      } else {
        return joinWaitList;
      }
    }
  }

  Future<void> cancelSubscription() async {
    emit(state.copyWith(buttonIsLoading: true));

    final result = await _activitiesRepository.cancelSubscription(activityId);

    result.fold(
      (_) {
        view?.dialogError(
          'Hmm...',
          'Tivemos um problema ao cancelar sua inscrição, tente novamente.',
        );
      },
      (_) {
        emit(state.copyWith(isSubscribe: false));
        view?.successDialog(
          'Sua inscrição foi cancelada com sucesso, sentiremos sua falta!',
        );
      },
    );

    emit(state.copyWith(buttonIsLoading: false));
  }

  Future<void> removeFromWaitList() async {
    emit(state.copyWith(buttonIsLoading: true));

    final result = await _activitiesRepository.removeFromWaitList(activityId);

    result.fold(
      (_) {
        view?.dialogError(
          'Hm...',
          'Houve um erro ao remover você da lista de espera, tente novamente',
        );
      },
      (_) {
        emit(state.copyWith(isWaitList: false));
        view?.successDialog('Removemos você da lista de espera com sucesso');
      },
    );

    emit(state.copyWith(buttonIsLoading: false));
  }

  Future<void> subscribe() async {
    emit(state.copyWith(buttonIsLoading: true));

    final result = await _activitiesRepository.subscribe(activityId);

    result.fold(
      (e) {
        switch (e) {
          case SubscribeActivityResult.failed:
            view?.dialogError(
              'Ops, tivemos um problema',
              'Houve um erro ao tentar se inscrever, tente novamente',
            );
            emit(state.copyWith(buttonIsLoading: false));
          case SubscribeActivityResult.isFull:
            view?.noVacancies();
            emit(state.copyWith(hasVacancies: false, buttonIsLoading: false));
        }
      },
      (value) {
        view?.successDialog(
          'Você se inscreveu nessa atividade com sucesso, basta comparecer no local nos dias informados nessa tela',
        );
        emit(state.copyWith(
          buttonIsLoading: false,
          isSubscribe: true,
        ));
      },
    );

    emit(state.copyWith(buttonIsLoading: false));
  }

  Future<void> joinWaitList() async {
    emit(state.copyWith(buttonIsLoading: true));

    final result = await _activitiesRepository.joinWaitList(activityId);

    result.fold(
      (_) {
        view?.dialogError(
          'Hm...',
          'Houve um erro ao colocar você na lista de espera, tente novamente',
        );
      },
      (_) {
        emit(state.copyWith(isWaitList: true));
        view?.successDialog(
          'Você foi inserido na lista de espera, '
          'quando for chamado chegará uma notificação pra você, '
          'então não desinstale o app',
        );
      },
    );

    emit(state.copyWith(buttonIsLoading: false));
  }

  void dispose() {
    view = null;
  }
}
