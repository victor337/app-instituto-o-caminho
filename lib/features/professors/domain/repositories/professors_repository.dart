import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/professors/domain/entities/professor.dart';
import 'package:instituto_o_caminho/features/professors/domain/results/get_professor_data_by_id_result.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ProfessorsRepository {
  Future<Result<Professor, GetProfessorDataByIdResult>> getProfessorDataById(
    String id,
  );

  Future<Result<List<Professor>, GetProfessorDataByIdResult>> getProfessors();
}

class ProfessorsRepositoryImpl implements ProfessorsRepository {
  ProfessorsRepositoryImpl({required this.loggerRepository});
  final LoggerRepository loggerRepository;

  @override
  Future<Result<Professor, GetProfessorDataByIdResult>> getProfessorDataById(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('professors').doc(id).get();

      return Result.success(Professor.fromJson(response.data()!));
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar professor pelo ID');
      return const Result.error(GetProfessorDataByIdResult.failed);
    }
  }

  @override
  Future<Result<List<Professor>, GetProfessorDataByIdResult>>
      getProfessors() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('professors').get();

      return Result.success(
          [for (final p in response.docs) Professor.fromJson(p.data())]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar professores');
      return const Result.error(GetProfessorDataByIdResult.failed);
    }
  }
}
