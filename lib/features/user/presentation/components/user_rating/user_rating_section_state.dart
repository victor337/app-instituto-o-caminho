part of 'user_rating_section_cubit.dart';

@immutable
abstract class UserRatingSectionState {}

class UserRatingSectionLoading extends UserRatingSectionState {}

class UserRatingSectionError extends UserRatingSectionState {}

class UserRatingSectionDone extends UserRatingSectionState {
  UserRatingSectionDone({
    required this.userRating,
  });

  final UserRating? userRating;
}
