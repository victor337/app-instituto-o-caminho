part of 'activity_details_page_cubit.dart';

class ActivityDetailsPageState {
  ActivityDetailsPageState({
    this.isLoading = false,
    this.activity,
    this.isSubscribe = false,
    this.isWaitList = false,
    this.hasVacancies = false,
  });

  ActivityDetailsPageState copyWith({
    bool? isLoading,
    Activity? activity,
    bool? isSubscribe,
    bool? isWaitList,
    bool? hasVacancies,
  }) {
    return ActivityDetailsPageState(
      isLoading: isLoading ?? this.isLoading,
      activity: activity ?? this.activity,
      isSubscribe: isSubscribe ?? this.isSubscribe,
      isWaitList: isWaitList ?? this.isWaitList,
      hasVacancies: hasVacancies ?? this.hasVacancies,
    );
  }

  String get buttonTitle {
    if (isSubscribe) {
      return 'Cancelar inscrição';
    } else if (isWaitList) {
      return 'Sair da lista de espera';
    } else {
      if (hasVacancies) {
        return 'Inscrever-se';
      } else {
        return 'Entrar na lista de espera';
      }
    }
  }

  final bool hasVacancies;
  final bool isLoading;
  final bool isSubscribe;
  final bool isWaitList;
  final Activity? activity;
}
