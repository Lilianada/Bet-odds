import 'package:dartz/dartz.dart';
import 'package:resultizer/src/core/error/error_handler.dart';
import 'package:resultizer/src/core/usecase/usecase.dart';
import 'package:resultizer/src/features/auth/domain/entities/user.dart';
import 'package:resultizer/src/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUseCase implements UseCase<User, NoParams> {
  final AuthRepository _repository;
  GoogleSignInUseCase(this._repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _repository.signInWithGoogle();
  }
}
