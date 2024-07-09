import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:instituto_o_caminho/features/history/domain/entities/history.dart';
import 'package:instituto_o_caminho/features/history/domain/results/get_history_result.dart';

abstract class HistoryRepository {
  Future<Either<GetHistoryResult, List<History>>> getHistory();
}

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl({
    required this.authRepository,
    required this.loggerRepository,
  });

  final AuthRepository authRepository;
  final LoggerRepository loggerRepository;

  @override
  Future<Either<GetHistoryResult, List<History>>> getHistory() async {
    final currentUserId = authRepository.currentUser!.id;

    try {
      final firestore = FirebaseFirestore.instance;

      final response = await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('history')
          .get();

      return Right([
        for (final history in response.docs) History.fromJson(history.data())
      ]);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Buscar histórico do usuário $currentUserId',
      );
      return const Left(GetHistoryResult.failed);
    }
  }
}
