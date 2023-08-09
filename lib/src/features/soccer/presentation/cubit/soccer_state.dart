import 'package:live_score/src/core/domain/entities/betting_odds.dart';

import '../../domain/entities/standings.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';

abstract class SoccerStates {}

class ScoreInitial extends SoccerStates {}

class SoccerChangeBottomNav extends SoccerStates {}

class SoccerLeaguesLoading extends SoccerStates {}

class SoccerLeaguesLoaded extends SoccerStates {
  final List<League> leagues;

  SoccerLeaguesLoaded(this.leagues);
}

class SoccerLeaguesLoadFailure extends SoccerStates {
  final String message;

  SoccerLeaguesLoadFailure(this.message);
}

class SoccerFixturesLoading extends SoccerStates {}

class SoccerFixturesLoaded extends SoccerStates {
  final List<SoccerFixture> fixtures;

  SoccerFixturesLoaded(this.fixtures);
}

class SoccerFixturesLoadFailure extends SoccerStates {
  final String message;

  SoccerFixturesLoadFailure(this.message);
}

class SoccerLiveFixturesLoaded extends SoccerStates {
  final List<SoccerFixture> fixtures;

  SoccerLiveFixturesLoaded(this.fixtures);
}

class SoccerLiveFixturesLoadFailure extends SoccerStates {
  final String message;

  SoccerLiveFixturesLoadFailure(this.message);
}

class SoccerCurrentFixturesChanges extends SoccerStates {}

class SoccerStandingsLoading extends SoccerStates {}

class SoccerStandingsLoaded extends SoccerStates {
  final Standings standings;

  SoccerStandingsLoaded(this.standings);
}

class SoccerStandingsLoadFailure extends SoccerStates {
  final String message;

  SoccerStandingsLoadFailure(this.message);
}

class SoccerOddsLoading extends SoccerStates {}

class SoccerOddsLoadFailure extends SoccerStates {
  final String message;

  SoccerOddsLoadFailure(this.message);
}

class SoccerOddsLoaded extends SoccerStates {
  final Map<int, BettingOdds> odds;

  SoccerOddsLoaded(this.odds);
}

