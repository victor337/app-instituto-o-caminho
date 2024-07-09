import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/cancel_subscription_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/remove_from_wait_list_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/get_activities_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/join_wait_list_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/subscribe_activity_result.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';

abstract class ActivitiesRepository {
  Future<Either<GetActivitiesResult, List<Activity>>> getActivities();
  Future<Either<GetActivitiesResult, Activity>> getActivityById(String id);
  Future<Either<GetActivitiesResult, List<String>>> getSubscribers(String id);
  Future<Either<GetActivitiesResult, bool>> getIfIsWaitList(String id);
  Future<Either<SubscribeActivityResult, bool>> subscribe(String id);
  Future<Either<CancelSubscriptionResult, bool>> cancelSubscription(String id);
  Future<Either<JoinWaitListResult, bool>> joinWaitList(String id);
  Future<Either<RemoveFromWaitListResult, bool>> removeFromWaitList(String id);
}

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  ActivitiesRepositoryImpl({
    required this.authRepository,
    required this.loggerRepository,
  });
  final AuthRepository authRepository;
  final LoggerRepository loggerRepository;

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
      loggerRepository.logInfo(e, s, 'Busca das atividades');
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
      loggerRepository.logInfo(e, s, 'Buscar atividade pelo ID: $id');
      return const Left(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Either<GetActivitiesResult, List<String>>> getSubscribers(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore
          .collection('activities')
          .doc(id)
          .collection('subscribers')
          .get();

      return Right([for (final user in response.docs) user.data()['userId']]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar inscritos em uma atividade');
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
      loggerRepository.logInfo(
        e,
        s,
        'Buscar se usuário está na lista de espera na atividade $id',
      );

      return const Left(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Either<SubscribeActivityResult, bool>> subscribe(String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      final activity = await firestore.collection('activities').doc(id).get();
      final subscribers = await firestore
          .collection('activities')
          .doc(id)
          .collection('subscribers')
          .get();

      if (activity.data()!['vacancies'] > subscribers.docs.length) {
        await firestore
            .collection('activities')
            .doc(id)
            .collection('subscribers')
            .doc(user!.id)
            .set({
          "userId": user.id,
        });
        return const Right(true);
      }

      return const Left(SubscribeActivityResult.isFull);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Inscrever usuário na atividade $id');
      return const Left(SubscribeActivityResult.failed);
    }
  }

  @override
  Future<Either<CancelSubscriptionResult, bool>> cancelSubscription(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      await firestore
          .collection('activities')
          .doc(id)
          .collection('subscribers')
          .doc(user!.id)
          .delete();

      return const Right(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Cancelar inscrição de usuário na atividade $id',
      );
      return const Left(CancelSubscriptionResult.failed);
    }
  }

  @override
  Future<Either<JoinWaitListResult, bool>> joinWaitList(String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      await firestore
          .collection('activities')
          .doc(id)
          .collection('wait-list')
          .doc(user!.id)
          .set({
        "userId": user.id,
      });
      return const Right(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Inserir usuário na lista de espera da atividade $id',
      );
      return const Left(JoinWaitListResult.failed);
    }
  }

  @override
  Future<Either<RemoveFromWaitListResult, bool>> removeFromWaitList(
      String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      await firestore
          .collection('activities')
          .doc(id)
          .collection('wait-list')
          .doc(user!.id)
          .delete();

      return const Right(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Remover usuário de uma lista de espera na atividade $id',
      );
      return const Left(RemoveFromWaitListResult.failed);
    }
  }
}
