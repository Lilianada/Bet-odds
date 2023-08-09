import 'package:live_score/src/core/domain/entities/betting_odds.dart';

class BettingOddsModel {
  final String date;
  final List<BettingOdds> oddsList;
  final String match;
  final BOFixture fixture;
  final BOLeague league;
  final BOTeams teams;
  final BOStatus status;
  final List<BOBetOption> odds;

  BettingOddsModel({
    required this.date,
    required this.oddsList,
    required this.match,
    required this.fixture,
    required this.league,
    required this.teams,
    required this.status,
    required this.odds,
  });

  factory BettingOddsModel.fromJson(Map<String, dynamic> json) {
    return BettingOddsModel(
      date: json['date'],
      oddsList: [],
      match: json['match'],
      fixture: BOFixture.fromJson(json['fixture']),
      league: BOLeague.fromJson(json['league']),
      teams: BOTeams.fromJson(json['teams']),
      status: BOStatus.fromJson(json['status']),
      odds: (json['odds'] as List).map((e) => BOBetOption.fromJson(e)).toList(),
    );
  }
}

class BOFixtureModel {
  final int id;
  final BOStatusModel status;
  final String date;
  final String homeTeam;
  final String awayTeam;

  BOFixtureModel({
    required this.id,
    required this.status,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory BOFixtureModel.fromJson(Map<String, dynamic> json) {
    return BOFixtureModel(
      id: json['id'],
      status: BOStatusModel.fromJson(json['status']),
      date: json['date'], // Assuming the JSON has 'date'
      homeTeam: json['homeTeam'], // Assuming the JSON has 'homeTeam'
      awayTeam: json['awayTeam'], // Assuming the JSON has 'awayTeam'
    );
  }
}

class BOLeagueModel {
  final int id;
  final int season;

  BOLeagueModel({required this.id, required this.season});

  factory BOLeagueModel.fromJson(Map<String, dynamic> json) {
    return BOLeagueModel(
      id: json['id'],
      season: json['season'],
    );
  }
}

class BOTeamsModel {
  final BOTeamModel home;
  final BOTeamModel away;

  BOTeamsModel({required this.home, required this.away});

  factory BOTeamsModel.fromJson(Map<String, dynamic> json) {
    return BOTeamsModel(
      home: BOTeamModel.fromJson(json['home']),
      away: BOTeamModel.fromJson(json['away']),
    );
  }
}

class BOTeamModel {
  final int id;
  final int goals;

  BOTeamModel({required this.id, required this.goals});

  factory BOTeamModel.fromJson(Map<String, dynamic> json) {
    return BOTeamModel(
      id: json['id'],
      goals: json['goals'],
    );
  }
}

class BOStatusModel {
  final String long;
  final int elapsed;
  final String seconds;

  BOStatusModel(
      {required this.long, required this.elapsed, required this.seconds});

  factory BOStatusModel.fromJson(Map<String, dynamic> json) {
    return BOStatusModel(
      long: json['long'],
      elapsed: json['elapsed'],
      seconds: json['seconds'],
    );
  }
}

class BetOption {
  final int id;
  final String name;
  final List<BetValue> values;

  BetOption({required this.id, required this.name, required this.values});

  factory BetOption.fromJson(Map<String, dynamic> json) {
    return BetOption(
      id: json['id'],
      name: json['name'],
      values:
          (json['values'] as List).map((e) => BetValue.fromJson(e)).toList(),
    );
  }
}

class BetValue {
  final String value;
  final String odd;
  final String? handicap;
  final String? main;
  final bool suspended;

  BetValue(
      {required this.value,
      required this.odd,
      this.handicap,
      this.main,
      required this.suspended});

  factory BetValue.fromJson(Map<String, dynamic> json) {
    return BetValue(
      value: json['value'],
      odd: json['odd'],
      handicap: json['handicap'],
      main: json['main'],
      suspended: json['suspended'],
    );
  }
}
