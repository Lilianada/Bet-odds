import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:odd_sprat/src/core/domain/entities/betting_odds.dart';

import '../../../odds/data/models/odds_model.dart';
import '../../../odds/presentation/widgets/match_status.dart';
import '../../../odds/presentation/widgets/soccer_match_status.dart';
import '../cubit/soccer_cubit.dart';
import '../widgets/news_card.dart';

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
    // Dummy data for Match Details
    final matchDate = DateTime.now();
    final matchTime = "3:00 PM";
    final venue = "Stadium A";

    // Dummy news data
    List<NewsItem> dummyNews = [
      NewsItem(
          headline:
              "Team A signs a new player! Lorem Ipsum is simply dummy text of the printing an",
          imageUrl: "assets/images/@wanleee.jpeg"),
      NewsItem(
          headline:
              "Team B wins the championship! Lorem Ipsum is simply dummy text of the printing an",
          imageUrl: "assets/images/New Balance 2002.jpeg"),
      NewsItem(
          headline:
              "Star player injured in yesterday's match. Lorem Ipsum is simply dummy text of the printing an",
          imageUrl:
              "assets/images/new balance 2002r protection pack rain cloud.jpeg"),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Match Details
            Card(
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Logo Image and Logo Name (You can replace 'FlutterLogo' with your actual logo)
                    const Row(
                      children: [
                        FlutterLogo(size: 40), // Placeholder for logo image
                        SizedBox(width: 8),
                        Text(
                          "Logo Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ), // Replace with actual logo name
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Team details
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: FlutterLogo(
                                  size:
                                      30), // Placeholder for team logo made circular
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Team A",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ), // Replace with actual team name
                          ],
                        ),
                        Text(
                          "3 - 2",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ), // Replace with actual score
                        Row(
                          children: [
                            ClipOval(
                              child: FlutterLogo(
                                  size:
                                      30), // Placeholder for team logo made circular
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Team B",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ), // Replace with actual team name
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Date, Time, and Venue
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(matchDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          matchTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          venue,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Flash Score News
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // This aligns child widgets to the start (left for LTR languages)
              children: [
                // Header for Flash Score News
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Text(
                    "Flash Score News",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                // News items
                ...dummyNews.map((news) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              news.imageUrl, // News image
                              width: 150,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(news.headline),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewsItem {
  final String headline;
  final String imageUrl;

  NewsItem({required this.headline, required this.imageUrl});
}
