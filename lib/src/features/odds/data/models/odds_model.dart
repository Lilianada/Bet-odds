class BettingOddsModel {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Status status;
  final List<BetOption> odds;

  BettingOddsModel({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.status,
    required this.odds,
  });

  factory BettingOddsModel.fromJson(Map<String, dynamic> json) {
    return BettingOddsModel(
      fixture: Fixture.fromJson(json['fixture']),
      league: League.fromJson(json['league']),
      teams: Teams.fromJson(json['teams']),
      status: Status.fromJson(json['status']),
      odds: (json['odds'] as List).map((e) => BetOption.fromJson(e)).toList(),
    );
  }
}

class Fixture {
  final int id;
  final Status status;
  final String date;
  final String homeTeam;
  final String awayTeam;

  Fixture({
    required this.id,
    required this.status,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      status: Status.fromJson(json['status']),
      date: json['date'], // Assuming the JSON has 'date'
      homeTeam: json['homeTeam'], // Assuming the JSON has 'homeTeam'
      awayTeam: json['awayTeam'], // Assuming the JSON has 'awayTeam'
    );
  }
}

class League {
  final int id;
  final int season;

  League({required this.id, required this.season});

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      season: json['season'],
    );
  }
}

class Teams {
  final Team home;
  final Team away;

  Teams({required this.home, required this.away});

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: Team.fromJson(json['home']),
      away: Team.fromJson(json['away']),
    );
  }
}

class Team {
  final int id;
  final int goals;

  Team({required this.id, required this.goals});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      goals: json['goals'],
    );
  }
}

class Status {
  final String long;
  final int elapsed;
  final String seconds;

  Status({required this.long, required this.elapsed, required this.seconds});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
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
