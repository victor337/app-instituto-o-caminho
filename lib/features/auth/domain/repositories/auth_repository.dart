import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instituto_o_caminho/features/auth/domain/entities/app_user.dart';
import 'package:instituto_o_caminho/features/auth/domain/entities/register_user_data.dart';
import 'package:instituto_o_caminho/features/auth/domain/results/register_user_result.dart';

abstract class AuthRepository {
  Future<Either<RegisterUserResult, bool>> registerUser(RegisterUserData data);
}

class AuthRepositoryImpl implements AuthRepository {
  AppUser? user;

  @override
  Future<Either<RegisterUserResult, bool>> registerUser(
    RegisterUserData data,
  ) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firebaseAuth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.pass,
      );

      await firestore.collection('users').add(data.toMap());

      return const Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return const Left(RegisterUserResult.emailAlreadyUse);
      }
      return const Left(RegisterUserResult.failed);
    } catch (e) {
      return const Left(RegisterUserResult.failed);
    }
  }
}
