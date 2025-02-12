import 'package:bloc/bloc.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/features/punishments/domain/entities/punishment.dart';
import 'package:instituto_o_caminho/features/punishments/domain/repositories/punishments_repository.dart';
import 'package:meta/meta.dart';

part 'punishments_section_state.dart';

class PunishmentsSectionCubit extends Cubit<PunishmentsSectionState> {
  PunishmentsSectionCubit() : super(PunishmentsSectionLoading()) {
    init();
  }

  final PunishmentsRepository _punishmentsRepository = getIt();

  Future<void> init() async {
    final result = await _punishmentsRepository.getPunishmentsOfUser();

    result.when(
      (punishments) {
        emit(PunishmentsSectionDone(
          punishments: punishments,
        ));
      },
      (_) {
        emit(PunishmentsSectionError());
      },
    );
  }
}
