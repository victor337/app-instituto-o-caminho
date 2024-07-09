import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/get_activities_result.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';

abstract class ActivitiesRepository {
  Future<Either<GetActivitiesResult, List<Activity>>> getActivities();
  Future<Either<GetActivitiesResult, Activity>> getActivityById(String id);
  Future<Either<GetActivitiesResult, List<String>>> getSubscribers(String id);
  Future<Either<GetActivitiesResult, bool>> getIfIsWaitList(String id);
}

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  ActivitiesRepositoryImpl({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<GetActivitiesResult, List<Activity>>> getActivities() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('activities').get();

      return Right([
        for (final activity in response.docs)
          Activity.fromJson(
            activity.data(),
          )
      ]);
    } catch (e, s) {
      print(e);
      print(s);
      return const Left(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Either<GetActivitiesResult, Activity>> getActivityById(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('activities').doc(id).get();

      return Right(Activity.fromJson(
        response.data()!,
      ));
    } catch (e, s) {
      print(e);
      print(s);
      return const Left(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Either<GetActivitiesResult, List<String>>> getSubscribers(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      final response = await firestore
          .collection('activities')
          .doc(id)
          .collection('subscribers')
          .get();

      return Right([for (final user in response.docs) user.data()['userId']]);
    } catch (e, s) {
      print(e);
      print(s);
      return const Left(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Either<GetActivitiesResult, bool>> getIfIsWaitList(String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      final response = await firestore
          .collection('activities')
          .doc(id)
          .collection('wait-list')
          .where('userId', isEqualTo: user!.id)
          .get();

      return Right(response.docs.isNotEmpty);
    } catch (e, s) {
      print(e);
      print(s);
      return const Left(GetActivitiesResult.failed);
    }
  }
}
