import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/activities/domain/entities/activity.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/cancel_subscription_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/generic_error.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/get_activities_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/join_wait_list_result.dart';
import 'package:instituto_o_caminho/features/activities/domain/results/subscribe_activity_result.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ActivitiesRepository {
  Future<Result<List<Activity>, GetActivitiesResult>> getActivities();
  Future<Result<Activity, GetActivitiesResult>> getActivityById(String id);
  Future<Result<List<String>, GetActivitiesResult>> getSubscribers(String id);
  Future<Result<bool, GetActivitiesResult>> getIfIsWaitList(String id);
  Future<Result<bool, SubscribeActivityResult>> subscribe(String id);
  Future<Result<bool, CancelSubscriptionResult>> cancelSubscription(String id);
  Future<Result<bool, JoinWaitListResult>> joinWaitList(String id);
  Future<Result<bool, GenericError>> removeFromWaitList(String id);
  Future<Result<bool, GenericError>> cancelClass({
    required String id,
    required DateTime date,
    String? reason,
  });
}

class ActivitiesRepositoryImpl implements ActivitiesRepository {
  ActivitiesRepositoryImpl({
    required this.authRepository,
    required this.loggerRepository,
  });
  final AuthRepository authRepository;
  final LoggerRepository loggerRepository;

  @override
  Future<Result<List<Activity>, GetActivitiesResult>> getActivities() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('activities').get();

      return Result.success([
        for (final activity in response.docs)
          Activity.fromJson(
            activity.data(),
          )
      ]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Busca das atividades');
      return const Result.error(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Result<Activity, GetActivitiesResult>> getActivityById(
      String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore.collection('activities').doc(id).get();

      return Result.success(Activity.fromJson(
        response.data()!,
      ));
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar atividade pelo ID: $id');
      return const Result.error(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Result<List<String>, GetActivitiesResult>> getSubscribers(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final response = await firestore
          .collection('activities')
          .doc(id)
          .collection('subscribers')
          .get();

      return Result.success(
          [for (final user in response.docs) user.data()['userId']]);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Buscar inscritos em uma atividade');
      return const Result.error(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Result<bool, GetActivitiesResult>> getIfIsWaitList(String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      final response = await firestore
          .collection('activities')
          .doc(id)
          .collection('wait-list')
          .where('userId', isEqualTo: user!.id)
          .get();

      return Result.success(response.docs.isNotEmpty);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Buscar se usuário está na lista de espera na atividade $id',
      );

      return const Result.error(GetActivitiesResult.failed);
    }
  }

  @override
  Future<Result<bool, SubscribeActivityResult>> subscribe(String id) async {
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
        return const Result.success(true);
      }

      return const Result.error(SubscribeActivityResult.isFull);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Inscrever usuário na atividade $id');
      return const Result.error(SubscribeActivityResult.failed);
    }
  }

  @override
  Future<Result<bool, CancelSubscriptionResult>> cancelSubscription(
      String id) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      await firestore
          .collection('activities')
          .doc(id)
          .collection('subscribers')
          .doc(user!.id)
          .delete();

      return const Result.success(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Cancelar inscrição de usuário na atividade $id',
      );
      return const Result.error(CancelSubscriptionResult.failed);
    }
  }

  @override
  Future<Result<bool, JoinWaitListResult>> joinWaitList(String id) async {
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
      return const Result.success(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Inserir usuário na lista de espera da atividade $id',
      );
      return const Result.error(JoinWaitListResult.failed);
    }
  }

  @override
  Future<Result<bool, GenericError>> removeFromWaitList(
    String id,
  ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final user = authRepository.currentUser;

      await firestore
          .collection('activities')
          .doc(id)
          .collection('wait-list')
          .doc(user!.id)
          .delete();

      return const Result.success(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Remover usuário de uma lista de espera na atividade $id',
      );
      return const Result.error(GenericError.failed);
    }
  }

  @override
  Future<Result<bool, GenericError>> cancelClass({
    required String id,
    required DateTime date,
    String? reason,
  }) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore
          .collection('activities')
          .doc(id)
          .collection('cancellation')
          .doc()
          .set({
        'date': Timestamp.fromDate(date),
        'reason': reason,
      });

      return const Result.success(true);
    } catch (e, s) {
      loggerRepository.logInfo(
        e,
        s,
        'Cancelar uma atividade $id',
      );
      return const Result.error(GenericError.failed);
    }
  }
}
