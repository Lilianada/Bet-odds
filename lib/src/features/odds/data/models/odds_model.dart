import '../../../../core/domain/entities/betting_odds.dart';

class BettingOddsModel extends BettingOdds {
  const BettingOddsModel({
    required String homeTeam,
    required String awayTeam,
    required String homeTeamOdds,
    required String awayTeamOdds,
    required String drawOdds,
  }) : super(
          homeTeamOdds: homeTeamOdds,
          awayTeamOdds: awayTeamOdds,
          drawOdds: drawOdds,
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          homeOdds: 0.0,
        );

  factory BettingOddsModel.fromJson(Map<String, dynamic> json) =>
      BettingOddsModel(
        homeTeam: json['homeTeam'],
        awayTeam: json['awayTeam'],
        homeTeamOdds: json['homeTeamOdds'].trim(),
        awayTeamOdds: json['awayTeamOdds'],
        drawOdds: json['drawOdds'],
      );
}