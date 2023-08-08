import '../../../../core/domain/entities/betting_odds.dart';

abstract class BettingOddsStates {}

class BettingOddsInitial extends BettingOddsStates {}

class BettingOddsLoading extends BettingOddsStates {}

class BettingOddsLoaded extends BettingOddsStates {
  final List<BettingOdds> odds;

  BettingOddsLoaded(this.odds);
}

class BettingOddsLoadFailure extends BettingOddsStates {
  final String message;

  BettingOddsLoadFailure(this.message);
}