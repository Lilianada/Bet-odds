import 'package:equatable/equatable.dart';

class BettingOdds extends Equatable {
  final String homeTeamOdds;
  final String awayTeamOdds;
  final String drawOdds;
  final String homeTeam;
  final String awayTeam;
  final double homeOdds;

  const BettingOdds({
    required this.homeTeamOdds,
    required this.awayTeamOdds,
    required this.drawOdds,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeOdds,
  });

  @override
  List<Object?> get props => [homeTeamOdds, awayTeamOdds, drawOdds, homeTeam, awayTeam, homeOdds];
  
}