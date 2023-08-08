import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/betting_odds_repository.dart';

class GetBettingOdds implements UseCase<List<BettingOdds>, String> {
  final BettingOddsRepository bettingOddsRepository;

  GetBettingOdds({required this.bettingOddsRepository});

  @override
  Future<Either<Failure, List<BettingOdds>>> call(String date) async {
    return await bettingOddsRepository.getOdds(date: date);
  }
}