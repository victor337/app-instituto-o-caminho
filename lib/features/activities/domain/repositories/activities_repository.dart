import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/get_activities_result.dart';

abstract class ActivitiesRepository {
  Future<Either<GetActivitiesResult, List<Activity>>> getActivities();
}

class ActivitiesRepositoryImpl implements ActivitiesRepository {
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
    } catch (e) {
      print(e);
      return const Left(GetActivitiesResult.failed);
    }
  }
}
