import 'dart:convert';

import 'package:equatable/equatable.dart';

class BettingOdds extends Equatable {
  final BOFixture fixture;
  final BOLeague league;
  final BOTeams teams;
  final BOStatus status;
  final List<BOBetOption> odds;
  final String date;
  final List<BettingOdds> oddsList;
  final String match;

  const BettingOdds({
    required this.date,
    required this.oddsList,
    required this.match,
    required this.fixture,
    required this.league,
    required this.teams,
    required this.status,
    required this.odds,
  });

  @override
  List<Object?> get props => [fixture, league, teams, status, odds];
}

class BOFixture extends Equatable {
  final int id;
  final BOStatus status;

  const BOFixture({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toMap(),
    };
  }

  factory BOFixture.fromMap(Map<String, dynamic> map) {
    return BOFixture(
      id: map['id']?.toInt() ?? 0,
      status: BOStatus.fromMap(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BOFixture.fromJson(String source) =>
      BOFixture.fromMap(json.decode(source));
}

class BOLeague extends Equatable {
  final int id;
  final int season;

  const BOLeague({required this.id, required this.season});

  @override
  List<Object?> get props => [id, season];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'season': season,
    };
  }

  factory BOLeague.fromMap(Map<String, dynamic> map) {
    return BOLeague(
      id: map['id']?.toInt() ?? 0,
      season: map['season']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BOLeague.fromJson(String source) =>
      BOLeague.fromMap(json.decode(source));
}

class BOTeams extends Equatable {
  final BOTeam home;
  final BOTeam away;

  const BOTeams({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];

  Map<String, dynamic> toMap() {
    return {
      'home': home.toMap(),
      'away': away.toMap(),
    };
  }

  factory BOTeams.fromMap(Map<String, dynamic> map) {
    return BOTeams(
      home: BOTeam.fromMap(map['home']),
      away: BOTeam.fromMap(map['away']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BOTeams.fromJson(String source) =>
      BOTeams.fromMap(json.decode(source));
}

class BOTeam extends Equatable {
  final int id;
  final int goals;

  const BOTeam({required this.id, required this.goals});

  @override
  List<Object?> get props => [id, goals];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goals': goals,
    };
  }

  factory BOTeam.fromMap(Map<String, dynamic> map) {
    return BOTeam(
      id: map['id']?.toInt() ?? 0,
      goals: map['goals']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BOTeam.fromJson(String source) => BOTeam.fromMap(json.decode(source));
}

class BOStatus extends Equatable {
  final String long;
  final int elapsed;
  final String seconds;

  const BOStatus(
      {required this.long, required this.elapsed, required this.seconds});

  @override
  List<Object?> get props => [long, elapsed, seconds];

  Map<String, dynamic> toMap() {
    return {
      'long': long,
      'elapsed': elapsed,
      'seconds': seconds,
    };
  }

  factory BOStatus.fromMap(Map<String, dynamic> map) {
    return BOStatus(
      long: map['long'] ?? '',
      elapsed: map['elapsed']?.toInt() ?? 0,
      seconds: map['seconds'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BOStatus.fromJson(String source) =>
      BOStatus.fromMap(json.decode(source));
}

class BOBetOption extends Equatable {
  final int id;
  final String name;
  final List<BetValue> values;

  const BOBetOption(
      {required this.id, required this.name, required this.values});

  @override
  List<Object?> get props => [id, name, values];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory BOBetOption.fromMap(Map<String, dynamic> map) {
    return BOBetOption(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      values:
          List<BetValue>.from(map['values']?.map((x) => BetValue.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BOBetOption.fromJson(String source) =>
      BOBetOption.fromMap(json.decode(source));
}

class BetValue extends Equatable {
  final String value;
  final String odd;
  final String? handicap;
  final String? main;
  final bool suspended;

  const BetValue({
    required this.value,
    required this.odd,
    this.handicap,
    this.main,
    required this.suspended,
  });

  @override
  List<Object?> get props => [value, odd, handicap, main, suspended];

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'odd': odd,
      'handicap': handicap,
      'main': main,
      'suspended': suspended,
    };
  }

  factory BetValue.fromMap(Map<String, dynamic> map) {
    return BetValue(
      value: map['value'] ?? '',
      odd: map['odd'] ?? '',
      handicap: map['handicap'],
      main: map['main'],
      suspended: map['suspended'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BetValue.fromJson(String source) =>
      BetValue.fromMap(json.decode(source));
}
