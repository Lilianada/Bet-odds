import 'package:equatable/equatable.dart';

class BettingOdds extends Equatable {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Status status;
  final List<BetOption> odds;
  final String date;
  final List<BettingOdds> oddsList;
  final String match;

  const BettingOdds(
    this.date,
    this.oddsList,
    this.match, {
    required this.fixture,
    required this.league,
    required this.teams,
    required this.status,
    required this.odds,
  });

  @override
  List<Object?> get props => [fixture, league, teams, status, odds];
}

class Fixture extends Equatable {
  final int id;
  final Status status;

  const Fixture({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}

class League extends Equatable {
  final int id;
  final int season;

  const League({required this.id, required this.season});

  @override
  List<Object?> get props => [id, season];
}

class Teams extends Equatable {
  final Team home;
  final Team away;

  const Teams({required this.home, required this.away});

  @override
  List<Object?> get props => [home, away];
}

class Team extends Equatable {
  final int id;
  final int goals;

  const Team({required this.id, required this.goals});

  @override
  List<Object?> get props => [id, goals];
}

class Status extends Equatable {
  final String long;
  final int elapsed;
  final String seconds;

  const Status({required this.long, required this.elapsed, required this.seconds});

  @override
  List<Object?> get props => [long, elapsed, seconds];
}

class BetOption extends Equatable {
  final int id;
  final String name;
  final List<BetValue> values;

  const BetOption({required this.id, required this.name, required this.values});

  @override
  List<Object?> get props => [id, name, values];
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
}
