import '../../container_injector.dart';
import '../../core/api/dio_helper.dart';
import '../../core/network/network_info.dart';
import 'data/datasources/odds_data_source.dart';
import 'data/repositories/betting_odds_repository_impl.dart';
import 'domain/use_cases/get_betting_odds.dart';
import 'presentation/cubit/betting_odds_cubit.dart';

void initOdds() {
  sl.registerLazySingleton<BettingOddsDataSourceImpl>(
    () => BettingOddsDataSourceImpl(dioHelper: sl<DioHelper>()),
  );
  sl.registerLazySingleton<BettingOddsRepositoryImpl>(
    () => BettingOddsRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      bettingOddsDataSource: sl<BettingOddsDataSourceImpl>(),
    ),
  );
  sl.registerLazySingleton<GetBettingOddsUseCase>(() => GetBettingOddsUseCase(
      bettingOddsRepository: sl<BettingOddsRepositoryImpl>()));
  sl.registerFactory<BettingOddsCubit>(
    () => BettingOddsCubit(
      getBettingOddsUseCase: sl<GetBettingOddsUseCase>(),
    ),
  );
}
