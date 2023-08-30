import 'package:dartz/dartz.dart';

import 'package:resultizer/src/core/error/error_handler.dart';
import 'package:resultizer/src/core/usecase/usecase.dart';
import 'package:resultizer/src/features/auth/domain/entities/user.dart';
import 'package:resultizer/src/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await _repository.logInWithEmail(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({
    required this.email,
    required this.password, required String name,
  });
}
