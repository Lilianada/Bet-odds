import 'package:dartz/dartz.dart';
import 'package:odd_sprat/src/core/error/error_handler.dart';
import 'package:odd_sprat/src/core/usecase/usecase.dart';
import 'package:odd_sprat/src/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase implements UseCase<bool, NoParams> {
  final AuthRepository _repository;
  SignOutUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _repository.signOut();
  }
}
