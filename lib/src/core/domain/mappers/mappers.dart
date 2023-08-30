import 'package:resultizer/src/features/odds/data/models/odds_model.dart';

import '../../models/fixture_league.dart';
import '../../models/fixture_model.dart';
import '../../models/goals_model.dart';
import '../../models/league_model.dart';
import '../../models/soccer_fixture_model.dart';
import '../../models/status_model.dart';
import '../../models/teams_model.dart';
import '../entities/betting_odds.dart';
import '../entities/fixture.dart';
import '../entities/fixture_league.dart';
import '../entities/goals.dart';
import '../entities/league.dart';
import '../entities/soccer_fixture.dart';
import '../entities/status.dart';
import '../entities/teams.dart';

extension StatusExtension on StatusModel {
  Status toDomain() => Status(long: long, short: short, elapsed: elapsed);
}

extension TeamExtension on TeamModel {
  Team toDomain() => Team(id: id, name: name, logo: logo, winner: winner);
}

extension TeamsExtension on TeamsModel {
  Teams toDomain() => Teams(home: home, away: away);
}

extension GoalsExtension on GoalsModel {
  Goals toDomain() => Goals(home: home, away: away);
}

extension FixtureLeagueExtension on FixtureLeagueModel {
  FixtureLeague toDomain() => FixtureLeague(
      id: id, name: name, logo: logo, season: season, round: round);
}

extension OddsExtension on BettingOddsModel {
  BettingOdds toDomain() => BettingOdds(
        update: update,
        fixture: fixture,
        league: league,
        teams: teams,
        status: status,
        odds: odds,
      );
}

extension FixtureExtension on FixtureModel {
  Fixture toDomain() =>
      Fixture(id: id, date: date, referee: referee, status: status);
}

extension SoccerFixtureExtension on SoccerFixtureModel {
  SoccerFixture toDomain() => SoccerFixture(
        fixture: fixture,
        fixtureLeague: fixtureLeague,
        teams: teams,
        goals: goals,
        odds: odds,
      );
}

extension LeagueExtension on LeagueModel {
  League toDomain() =>
      League(id: id, name: name, type: type, logo: logo, year: year);
}
