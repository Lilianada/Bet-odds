import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:live_score/src/core/domain/entities/league.dart';

import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/domain/mappers/mappers.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/network/network_info.dart';
import '../../../odds/data/models/odds_model.dart';
import '../../domain/entities/standings.dart';
import '../../domain/repositories/soccer_repository.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../datasources/soccer_data_source.dart';

class SoccerRepositoryImpl implements SoccerRepository {
  final SoccerDataSource soccerDataSource;
  final NetworkInfo networkInfo;

  SoccerRepositoryImpl({
    required this.soccerDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SoccerFixture>>> getDayFixtures(
      {required String date}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getDayFixtures(date: date);
        List<SoccerFixture> fixtures =
            result.map((fixture) => fixture.toDomain()).toList();
        return Right(fixtures);
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<League>>> getLeagues() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getLeagues();
        // Assuming the dataSource returns a list of data models and
        // there's a toDomain() method to convert them to domain models
        List<League> leagues = result.map((e) => e.toDomain()).toList();
        return Right(leagues);
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SoccerFixture>>> getLiveFixtures() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getLiveFixtures();
        List<SoccerFixture> fixtures =
            result.map((fixture) => fixture.toDomain()).toList();
        return Right(fixtures);
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, BettingOdds>> getOdds({required int leagueId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getOdds(leagueId: leagueId);

        // Assuming you have a BettingOddsModel with a fromJson method
        final oddsModel =
            BettingOddsModel.fromJson(result as Map<String, dynamic>);

        // Convert the BettingOddsModel to the domain entity BettingOdds
        final bettingOdds = oddsModel.toDomain();

        return Right(bettingOdds);
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }

  @override
  Future<Either<Failure, Standings>> getStandings(
      {required StandingsParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soccerDataSource.getStandings(params: params);
        Standings standings = result;
        return Right(standings);
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.networkConnectError.getFailure());
    }
  }
}
