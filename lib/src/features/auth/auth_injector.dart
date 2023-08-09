import 'package:live_score/src/container_injector.dart';
import 'package:live_score/src/core/network/network_info.dart';
import 'package:live_score/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:live_score/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:live_score/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:live_score/src/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:live_score/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:live_score/src/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:live_score/src/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:live_score/src/features/auth/presentation/cubit/auth_cubit.dart';

void initAuth() {
  sl
    ..registerLazySingleton<AuthDatasource>(() => FirebaseAuthDatasource())
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        datasource: sl<FirebaseAuthDatasource>(),
        networkInfo: sl<NetworkInfoImpl>()))
    ..registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(sl<AuthRepositoryImpl>()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepositoryImpl>()),
    )
    ..registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(sl<AuthRepositoryImpl>()),
    )
    ..registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(sl<AuthRepositoryImpl>()),
    )
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
          googleSignInUseCase: sl<GoogleSignInUseCase>(),
          loginUseCase: sl<LoginUseCase>(),
          signOutUseCase: sl<SignOutUseCase>(),
          signupUseCase: sl<SignupUseCase>()),
    );
}
