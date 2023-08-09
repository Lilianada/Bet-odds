import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../domain/entities/standings.dart';
import '../../domain/entities/team_rank.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';
import '../widgets/leagues_header.dart';
import '../widgets/standings_item.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({Key? key}) : super(key: key);

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  Standings? standings;
  List<TeamRank>? _filteredStandings;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SoccerCubit cubit = context.read<SoccerCubit>();
    cubit.resetFilters();
  }

  _filterStandings(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredStandings = null;
      });
      return;
    }

    final List<TeamRank> filtered = standings!.standings
        .expand((group) => group)
        .where((teamRank) =>
            teamRank.team.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _filteredStandings = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoccerCubit, SoccerStates>(
      listener: (context, state) {
        if (state is SoccerStandingsLoaded) standings = state.standings;
        print("Received Standings: ${standings.toString()}");
      },
      builder: (context, state) {
        SoccerCubit cubit = context.read<SoccerCubit>();

        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: _filterStandings,
              ),
            ),
            const SizedBox(height: AppSize.s5),
            LeaguesView(leagues: cubit.filteredLeagues, getFixtures: false),
            if (state is SoccerStandingsLoading)
              const Center(
                  child: LinearProgressIndicator(color: AppColors.deepOrange)),
            if (_filteredStandings != null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: _filteredStandings!
                      .map((teamRank) => StandingsItem(teamRank: teamRank))
                      .toList(),
                ),
              ),
            if (standings != null && _filteredStandings == null)
              ...List.generate(
                standings!.standings.length,
                (index) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Example of displaying league details
                      Row(
                        children: [
                          Image.network(
                              standings!.standings[index][0].team.logo,
                              width: 40,
                              height: 40), // Assuming each team has a logo
                          const SizedBox(width: 10),
                          Text(standings!.standings[index][0].team
                              .name), // Assuming each team has a name
                        ],
                      ),
                      const SizedBox(height: AppSize.s10),

                      const StandingsHeaders(),
                      const SizedBox(height: AppSize.s10),
                      ...List.generate(standings!.standings[index].length,
                          (teamIndex) {
                        TeamRank team = standings!.standings[index][teamIndex];
                        return StandingsItem(teamRank: team);
                      }),
                      const SizedBox(height: AppSize.s10),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
