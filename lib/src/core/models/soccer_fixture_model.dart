import '../../features/odds/data/models/odds_model.dart';
import '../domain/entities/betting_odds.dart';
import '../domain/entities/fixture.dart';
import '../domain/entities/fixture_league.dart';
import '../domain/entities/goals.dart';
import '../domain/entities/soccer_fixture.dart';
import '../domain/entities/teams.dart';
import '../domain/mappers/mappers.dart';
import 'fixture_league.dart';
import 'fixture_model.dart';
import 'goals_model.dart';
import 'teams_model.dart';

class SoccerFixtureModel extends SoccerFixture {
  const SoccerFixtureModel(
      {required Fixture fixture,
      required FixtureLeague fixtureLeague,
      required Teams teams,
      required Goals goals,
      required BettingOdds odds,
      })
      : super(
          fixture: fixture,
          fixtureLeague: fixtureLeague,
          teams: teams,
          goals: goals,
          odds: odds,
        );

  factory SoccerFixtureModel.fromJson(Map<String, dynamic> json) =>
      SoccerFixtureModel(
        fixture: FixtureModel.fromJson(json['fixture']).toDomain(),
        fixtureLeague: FixtureLeagueModel.fromJson(json['league']).toDomain(),
        teams: TeamsModel.fromJson(json['teams']).toDomain(),
        goals: GoalsModel.fromJson(json['goals']).toDomain(),
        odds: BettingOddsModel.fromJson(json['odds']).toDomain(),
      );
}
