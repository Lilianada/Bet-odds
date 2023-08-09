import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    odds = await cubit.getOdds();
    setState(() {}); // Refresh the UI after fetching the data
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$odds"), // Displaying odds in the AppBar title for demonstration
      ),
      body: (odds == null)
          ? Center(child: CircularProgressIndicator()) // Show loading indicator until odds are fetched
          : ListView(
              children: [
                // Match Details
                MatchStatus(
                  SoccerMatchStatus(
                    long: odds!.fixture.status.long,
                    score: odds!.fixture.status.elapsed
                        .toString(), // Using 'elapsed' as a placeholder
                  ),
                  odds!.fixture.date,
                  odds!.fixture.homeTeam,
                  odds!.fixture.awayTeam,
                ),
                const Divider(),
                // Odds
                ...odds!.odds.map((betOption) {
                  return ListTile(
                    title: Text(betOption.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: betOption.values.map((value) {
                        return Text(
                          "${value.value.toUpperCase()}: ${value.odd}",
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
