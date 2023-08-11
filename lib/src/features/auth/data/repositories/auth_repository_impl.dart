import 'package:dartz/dartz.dart';
import 'package:live_score/src/core/error/error_handler.dart';
import 'package:live_score/src/core/error/firebase_error_handler.dart';
import 'package:live_score/src/core/error/response_status.dart';
import 'package:live_score/src/core/network/network_info.dart';
import 'package:live_score/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:live_score/src/features/auth/domain/entities/user.dart';
import 'package:live_score/src/features/auth/domain/mappers/mappers.dart';
import 'package:live_score/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.datasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, User>> logInWithEmail({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await datasource.logInWithEmail(email: email, password: password);
        final user = result.toDomain();
        return Right(user);
      } on AuthException catch (e) {
        return Left(Failure(code: 00, message: e.message));
      } catch (e) {
        return Left(DataSource.unexpected.getFailure());
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.signInWithGoogle();
        final user = result.toDomain();
        return Right(user);
      } on AuthException catch (e) {
        return Left(Failure(code: 00, message: e.message));
      } catch (e) {
        return Left(DataSource.unexpected.getFailure());
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.signOut();
        return Right(result);
      } catch (e) {
        return const Left(Failure(code: 00, message: 'Something went wrong'));
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.signUpWithEmail(
            email: email, password: password, name: name);
        final user = result.toDomain();
        return Right(user);
      } on AuthException catch (e) {
        return Left(Failure(code: 00, message: e.message));
      } catch (e) {
        return Left(DataSource.unexpected.getFailure());
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
