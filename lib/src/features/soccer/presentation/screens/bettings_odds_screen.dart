import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/src/core/domain/entities/betting_odds.dart';

import '../../../odds/data/models/odds_model.dart';
import '../../../odds/presentation/widgets/match_status.dart';
import '../../../odds/presentation/widgets/soccer_match_status.dart';
import '../cubit/soccer_cubit.dart';

class BettingOddsScreen extends StatefulWidget {
  const BettingOddsScreen({Key? key}) : super(key: key);

  @override
  _BettingOddsScreenState createState() => _BettingOddsScreenState();
}

class _BettingOddsScreenState extends State<BettingOddsScreen> {
  BettingOddsModel? odds;

  @override
  void initState() {
    super.initState();
    fetchOdds();
  }

  fetchOdds() async {
    SoccerCubit cubit = context.read<SoccerCubit>();
    // Fetch the odds data using cubit or any other method you have
    // For demonstration, I'm using a placeholder function named getBettingOdds
    odds = BettingOddsModel(
        status: BetStatus(),
        update: DateTime.now(),
        fixture: const BOFixture(
          id: 1,
          status: FixureStatus(long: 'long', elapsed: 1, seconds: ''),
        ),
        league: const BOLeague(id: 2, season: 2),
        teams: const BOTeams(
            home: BOTeam(id: 2, goals: 4), away: BOTeam(id: 3, goals: 5)),
        odds: []);
    setState(() {}); // Refresh the UI after fetching the data
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (odds == null)
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator until odds are fetched
          : ListView(
              children: [
                // Match Details
                MatchStatus(
                  SoccerMatchStatus(
                    long: 'odds!.fixture.status.long',
                    score: 'odds!.fixture.status.elapsed'
                        .toString(), // Using 'elapsed' as a placeholder
                  ),
                  odds!.update.toString(),
                  odds!.teams.home.goals.toString(),
                  odds!.teams.away.goals.toString(),
                ),
                const Divider(),
                // Odds
                ...odds!.odds.map((betOption) {
                  return ListTile(
                    title: Text(betOption.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: betOption.values.map((value) {
                        return Text(
                          "${value.value?.toUpperCase() ?? ''}: ${value.odd}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}
