import 'package:bloc/bloc.dart';
import 'package:resultizer/src/core/usecase/usecase.dart';
import 'package:resultizer/src/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:resultizer/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:resultizer/src/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:resultizer/src/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:resultizer/src/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GoogleSignInUseCase googleSignInUseCase;
  final LoginUseCase loginUseCase;
  final SignOutUseCase signOutUseCase;
  final SignupUseCase signupUseCase;

  AuthCubit({
    required this.googleSignInUseCase,
    required this.loginUseCase,
    required this.signOutUseCase,
    required this.signupUseCase,
  }) : super(AuthInitial());

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    final params = SignupParams(email: email, password: password, name: name);
    final result = await signupUseCase(params);
    result.fold((left) => emit(AuthLoadFailed(left.message)),
        (right) => emit(AuthLoadSuccess()));
  }

  Future<void> signUpWithGoogle() async {
    emit(AuthLoading());
    final result = await googleSignInUseCase(NoParams());
    result.fold((left) => emit(AuthLoadFailed(left.message)),
        (right) => emit(AuthLoadSuccess()));
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final params = LoginParams(email: email, password: password, name: '');
    final result = await loginUseCase(params);
    result.fold((left) => emit(AuthLoadFailed(left.message)),
        (right) => emit(AuthLoadSuccess()));
  }

  Future<void> logout() async {
    final result = await signOutUseCase(NoParams());
    result.fold((left) => emit(AuthLoadFailed(left.message)),
        (right) => emit(AuthSignOut()));
  }
}
