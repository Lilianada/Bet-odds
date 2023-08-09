import 'dart:convert';

import 'package:live_score/src/core/domain/entities/betting_odds.dart';

class BettingOddsModel {
  final DateTime update;
  final BOFixture fixture;
  final BOLeague league;
  final BOTeams teams;
  final BetStatus status;
  final List<BetOption> odds;

  BettingOddsModel({
    required this.update,
    required this.fixture,
    required this.league,
    required this.teams,
    required this.status,
    required this.odds,
  });

  factory BettingOddsModel.fromJson(Map<String, dynamic> json) {
    return BettingOddsModel(
      update: json['update'] != null
          ? DateTime.parse(json['update'])
          : DateTime.now(),
      fixture: BOFixture.fromMap(json['fixture']),
      league: BOLeague.fromMap(json['league']),
      teams: BOTeams.fromMap(json['teams']),
      status: BetStatus.fromMap(json['status']),
      odds: (json['odds'] as List).map((e) => BetOption.fromMap(e)).toList(),
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

class BetOptionModel {
  final int id;
  final String name;
  final List<BetValue> values;

  BetOptionModel({required this.id, required this.name, required this.values});

  factory BetOptionModel.fromJson(Map<String, dynamic> json) {
    return BetOptionModel(
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

class BetStatus {
  final bool? stopped;
  final bool? blocked;
  final bool? finished;
  BetStatus({
    this.stopped,
    this.blocked,
    this.finished,
  });

  BetStatus copyWith({
    bool? stopped,
    bool? blocked,
    bool? finished,
  }) {
    return BetStatus(
      stopped: stopped ?? this.stopped,
      blocked: blocked ?? this.blocked,
      finished: finished ?? this.finished,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stopped': stopped,
      'blocked': blocked,
      'finished': finished,
    };
  }

  factory BetStatus.fromMap(Map<String, dynamic> map) {
    return BetStatus(
      stopped: map['stopped'] ?? false,
      blocked: map['blocked'] ?? false,
      finished: map['finished'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BetStatus.fromJson(String source) =>
      BetStatus.fromMap(json.decode(source));

  @override
  String toString() =>
      'BetStatus(stopped: $stopped, blocked: $blocked, finished: $finished)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BetStatus &&
        other.stopped == stopped &&
        other.blocked == blocked &&
        other.finished == finished;
  }

  @override
  int get hashCode => stopped.hashCode ^ blocked.hashCode ^ finished.hashCode;
}
