import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/punishments/domain/entities/punishment.dart';
import 'package:instituto_o_caminho/features/user/domain/results/get_punishments_result.dart';

abstract class PunishmentsRepository {
  Future<Either<GetPunishmentsResult, List<Punishment>>> getPunishmentsOfUser();
}

class PunishmentsRepositoryImpl implements PunishmentsRepository {
  PunishmentsRepositoryImpl({
    required this.loggerRepository,
    required this.authRepository,
  });

  final LoggerRepository loggerRepository;
  final AuthRepository authRepository;

  @override
  Future<Either<GetPunishmentsResult, List<Punishment>>>
      getPunishmentsOfUser() async {
    try {
      final firestore = FirebaseFirestore.instance;

      final response = await firestore
          .collection('users')
          .doc(authRepository.currentUser!.id)
          .collection('punishments')
          .get();

      return Right([
        for (final p in response.docs)
          Punishment.fromJson(
            p.data(),
          ),
      ]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar punições do usuário');
      return const Left(GetPunishmentsResult.failed);
    }
  }
}
