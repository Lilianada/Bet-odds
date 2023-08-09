import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/soccer_repository.dart';

class BettingOddsUseCase implements UseCase<BettingOdds, int> {
  final SoccerRepository soccerRepository;

  BettingOddsUseCase({required this.soccerRepository});

  @override
  Future<Either<Failure, BettingOdds>> call(int leagueId) async {
    return await soccerRepository.getOdds(leagueId: leagueId);
  }
}