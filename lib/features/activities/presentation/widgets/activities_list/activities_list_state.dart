part of 'activities_list_cubit.dart';

@immutable
abstract class ActivitiesListState {}

class ActivitiesListError extends ActivitiesListState {}

class ActivitiesListLoading extends ActivitiesListState {}

class ActivitiesListDone extends ActivitiesListState {
  ActivitiesListDone({required this.activities});

  final List<Activity> activities;
}
