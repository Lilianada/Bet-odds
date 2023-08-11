import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/error/error_handler.dart';

abstract class BettingOddsRepository {
  Future<Either<Failure, List<BettingOdds>>> getOdds({required String date});
}
