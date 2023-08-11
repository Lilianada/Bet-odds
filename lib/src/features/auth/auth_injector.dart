import 'package:odd_sprat/src/container_injector.dart';
import 'package:odd_sprat/src/core/network/network_info.dart';
import 'package:odd_sprat/src/features/auth/data/datasources/auth_datasource.dart';
import 'package:odd_sprat/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:odd_sprat/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:odd_sprat/src/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:odd_sprat/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:odd_sprat/src/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:odd_sprat/src/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:odd_sprat/src/features/auth/presentation/cubit/auth_cubit.dart';

void initAuth() {
  sl
    ..registerLazySingleton<FakeAuthDatasource>(() => FakeAuthDatasource())
    ..registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(
        datasource: sl<FakeAuthDatasource>(),
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
