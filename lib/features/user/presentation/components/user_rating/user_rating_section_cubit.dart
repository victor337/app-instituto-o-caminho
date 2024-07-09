import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/history/domain/entities/history.dart';
import 'package:instituto_o_caminho/features/history/domain/repositories/history_repository.dart';
import 'package:instituto_o_caminho/features/punishments/domain/entities/punishment.dart';
import 'package:instituto_o_caminho/features/punishments/domain/repositories/punishments_repository.dart';
import 'package:instituto_o_caminho/features/user/domain/entities/user_rating.dart';
import 'package:meta/meta.dart';

part 'user_rating_section_state.dart';

class UserRatingSectionCubit extends Cubit<UserRatingSectionState> {
  UserRatingSectionCubit() : super(UserRatingSectionLoading()) {
    init();
  }

  final HistoryRepository _historyRepository = getIt();
  final PunishmentsRepository _punishmentsRepository = getIt();

  Future<void> init() async {
    final results = await Future.wait([
      _historyRepository.getHistoryOfUser(),
      _punishmentsRepository.getPunishmentsOfUser(),
    ]);

    if (results.any((e) => e.isLeft())) {
      return emit(UserRatingSectionError());
    }

    results[0].fold(
      (_) => null,
      (history) => results[1].fold(
        (_) => null,
        (punishments) {
          emit(UserRatingSectionDone(
            userRating: UserRating(
              history: history as List<History>,
              punishments: punishments as List<Punishment>,
            ),
          ));
        },
      ),
    );
  }
}
