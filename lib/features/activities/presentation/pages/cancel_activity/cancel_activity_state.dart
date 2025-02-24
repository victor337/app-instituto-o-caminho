import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';

final class CancelActivityState {
  const CancelActivityState({
    this.isLoading = false,
    this.activities = const [],
    this.selectActivity,
    this.date,
    this.reason,
  });

  CancelActivityState copyWith({
    bool? isLoading,
    List<Activity>? activities,
    Activity? selectActivity,
    String? reason,
    DateTime? date,
  }) {
    return CancelActivityState(
      isLoading: isLoading ?? this.isLoading,
      activities: activities ?? this.activities,
      selectActivity: selectActivity ?? this.selectActivity,
      reason: reason ?? this.reason,
      date: date ?? this.date,
    );
  }

  final bool isLoading;
  final List<Activity> activities;
  final Activity? selectActivity;
  final String? reason;
  final DateTime? date;
}
