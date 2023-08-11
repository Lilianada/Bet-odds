import 'package:dartz/dartz.dart';

import 'package:odd_sprat/src/core/error/error_handler.dart';
import 'package:odd_sprat/src/core/usecase/usecase.dart';
import 'package:odd_sprat/src/features/auth/domain/entities/user.dart';
import 'package:odd_sprat/src/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase implements UseCase<User, SignupParams> {
  final AuthRepository _repository;
  SignupUseCase(this._repository);
  @override
  Future<Either<Failure, User>> call(SignupParams params) async {
    return await _repository.signUpWithEmail(
        email: params.email, password: params.password, name: params.name);
  }
}

class SignupParams {
  final String email;
  final String password;
  final String name;
  SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
