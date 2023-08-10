import 'package:equatable/equatable.dart';
import 'package:odd_sprat/src/core/domain/entities/betting_odds.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';

class LeagueOfFixture extends Equatable {
  final List<SoccerFixture> fixtures = [];
  final League league;
  BettingOdds? odds;

  LeagueOfFixture({required this.league});

  @override
  List<Object?> get props => [league, fixtures];
}
