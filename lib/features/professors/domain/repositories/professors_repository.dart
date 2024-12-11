import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/professors/domain/entities/professor.dart';
import 'package:instituto_o_caminho/features/professors/domain/results/get_professor_data_by_id_result.dart';

abstract class ProfessorsRepository {
  Future<Either<GetProfessorDataByIdResult, Professor>> getProfessorDataById(
    String id,
  );

  Future<Either<GetProfessorDataByIdResult, List<Professor>>> getProfessors();
}

class ProfessorsRepositoryImpl implements ProfessorsRepository {
  ProfessorsRepositoryImpl({required this.loggerRepository});
  final LoggerRepository loggerRepository;

  @override
  Future<Either<GetProfessorDataByIdResult, Professor>> getProfessorDataById(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('professors').doc(id).get();

      return Right(Professor.fromJson(response.data()!));
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar professor pelo ID');
      return const Left(GetProfessorDataByIdResult.failed);
    }
  }

  @override
  Future<Either<GetProfessorDataByIdResult, List<Professor>>>
      getProfessors() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('professors').get();

      return Right(
          [for (final p in response.docs) Professor.fromJson(p.data())]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar professores');
      return const Left(GetProfessorDataByIdResult.failed);
    }
  }
}
