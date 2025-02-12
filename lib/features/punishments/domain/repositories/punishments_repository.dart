import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/punishments/domain/entities/punishment.dart';
import 'package:instituto_o_caminho/features/punishments/results/get_punishments_result.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class PunishmentsRepository {
  Future<Result<List<Punishment>, GetPunishmentsResult>> getPunishmentsOfUser();
  Future<Result<Punishment, GetPunishmentsResult>> getPunishmentById(
    String id,
  );
}

class PunishmentsRepositoryImpl implements PunishmentsRepository {
  PunishmentsRepositoryImpl({
    required this.loggerRepository,
    required this.authRepository,
  });

  final LoggerRepository loggerRepository;
  final AuthRepository authRepository;

  @override
  Future<Result<List<Punishment>, GetPunishmentsResult>>
      getPunishmentsOfUser() async {
    try {
      final firestore = FirebaseFirestore.instance;

      final response = await firestore
          .collection('punishments')
          .where('userId', isEqualTo: authRepository.currentUser!.id)
          .get();

      return Result.success([
        for (final p in response.docs)
          Punishment.fromJson(
            p.data(),
          ),
      ]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar punições do usuário');
      return const Result.error(GetPunishmentsResult.failed);
    }
  }

  @override
  Future<Result<Punishment, GetPunishmentsResult>> getPunishmentById(
    String id,
  ) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('punishments').doc(id).get();

      return Result.success(
        Punishment.fromJson(
          response.data()!,
        ),
      );
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar uma punição do usuário $id');
      return const Result.error(GetPunishmentsResult.failed);
    }
  }
}
