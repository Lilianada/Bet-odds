import 'package:dartz/dartz.dart';
import 'package:live_score/src/core/error/error_handler.dart';
import 'package:live_score/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmail(
      {required String email, required String password, required String name});
  Future<Either<Failure, User>> logInWithEmail(
      {required String email, required String password});
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, bool>> signOut();
}
