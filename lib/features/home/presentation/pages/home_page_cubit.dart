import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState());
}
