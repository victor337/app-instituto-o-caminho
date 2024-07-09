import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instituto_o_caminho/core/analytics/logger_repository.dart';
import 'package:instituto_o_caminho/features/auth/domain/entities/app_user.dart';
import 'package:instituto_o_caminho/features/auth/domain/entities/register_user_data.dart';
import 'package:instituto_o_caminho/features/auth/domain/results/login_result.dart';
import 'package:instituto_o_caminho/features/auth/domain/results/register_user_result.dart';

abstract class AuthRepository {
  AppUser? get currentUser;
  Future<Either<RegisterUserResult, bool>> registerUser(RegisterUserData data);
  Future<Either<LoginResult, AppUser>> login(String email, String pass);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.loggerRepository});
  final LoggerRepository loggerRepository;

  AppUser? _user;

  @override
  AppUser? get currentUser {
    return _user;
  }

  @override
  Future<Either<RegisterUserResult, bool>> registerUser(
    RegisterUserData data,
  ) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.pass,
      );

      await firestore.collection('users').doc(result.user!.uid).set(
            data.toMap()
              ..addAll({
                "id": result.user!.uid,
              }),
          );

      return const Right(true);
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'email-already-in-use') {
        return const Left(RegisterUserResult.emailAlreadyUse);
      }
      loggerRepository.logInfo(e, s, 'Registrar usuário');
      return const Left(RegisterUserResult.failed);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Registrar usuário');
      return const Left(RegisterUserResult.failed);
    }
  }

  @override
  Future<Either<LoginResult, AppUser>> login(String email, String pass) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final doc =
          await firestore.collection('users').doc(result.user!.uid).get();

      _user = AppUser.fromJson(doc.data()!);
      return Right(_user!);
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'wrong-password') {
        return const Left(LoginResult.incorrectPass);
      } else if (e.code == 'user-not-found') {
        return const Left(LoginResult.noUser);
      } else if (e.code == 'invalid-credential') {
        return const Left(LoginResult.noUser);
      }
      loggerRepository.logInfo(e, s, 'Login de usuário');
      return const Left(LoginResult.failed);
    } catch (e, s) {
      loggerRepository.logInfo(e, s, 'Login de usuário');
      return const Left(LoginResult.failed);
    }
  }
}
