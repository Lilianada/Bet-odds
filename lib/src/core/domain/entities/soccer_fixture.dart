import 'package:equatable/equatable.dart';
import 'package:live_score/src/core/domain/entities/fixture.dart';
import 'package:live_score/src/core/domain/entities/teams.dart';
import 'betting_odds.dart';
import 'fixture_league.dart';
import 'goals.dart';

class SoccerFixture extends Equatable {
  final Fixture fixture;
  final FixtureLeague fixtureLeague;
  final Teams teams;
  final Goals goals;
  final BettingOdds? odds;

  const SoccerFixture({
    required this.fixture,
    required this.fixtureLeague,
    required this.teams,
    required this.goals,
    required this.odds,
  });

  @override
  List<Object?> get props => [fixture, fixtureLeague, teams, goals, odds];
}
