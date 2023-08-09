import 'package:flutter/material.dart';

import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
import '../../../fixture/presentation/widgets/fixture_details.dart';

class BettingOddsScreen extends StatelessWidget {
  final BettingOdds odds;

  const  BettingOddsScreen({Key? key, required this.odds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.odds),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Assuming you have a FixtureDetails widget
          // FixtureDetails(fixture: bettingOdds.fixture),
          BettingOddsView(bettingOdds: odds),
        ],
      ),
    );
  }
}

class BettingOddsView extends StatelessWidget {
  final BettingOdds bettingOdds;

  const BettingOddsView({Key? key, required this.bettingOdds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is just an example. Adjust according to your BettingOdds structure.
    var homeTeamOdds = bettingOdds.odds
        .firstWhere((o) => o.name == "Which team will score the 2nd goal?")
        .values
        .first
        .odd;
    var awayTeamOdds = bettingOdds.odds
        .firstWhere((o) => o.name == "Which team will score the 2nd goal?")
        .values
        .last
        .odd;

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          const Text(
            AppStrings.homeOdds,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(homeTeamOdds),
          const Text(
            AppStrings.awayOdds,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(awayTeamOdds),
        ],
      ),
    );
  }
}
