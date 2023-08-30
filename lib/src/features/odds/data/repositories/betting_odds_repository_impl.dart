import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resultizer/src/core/domain/mappers/mappers.dart';

import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/betting_odds_repository.dart';
import '../datasources/odds_data_source.dart';

class BettingOddsRepositoryImpl implements BettingOddsRepository {
  final BettingOddsDataSource bettingOddsDataSource;
  final NetworkInfo networkInfo;

  BettingOddsRepositoryImpl({
    required this.bettingOddsDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BettingOdds>>> getOdds(
      {required String date}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await bettingOddsDataSource.getOdds(date: date);
        final odds = result.map((fixture) => fixture.toDomain()).toList();
        return Right(odds);
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
