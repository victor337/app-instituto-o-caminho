part of 'home_page_cubit.dart';

class HomePageState {
  HomePageState({this.activities, this.isLoading = false});

  final List<Activity>? activities;
  final bool isLoading;
}
