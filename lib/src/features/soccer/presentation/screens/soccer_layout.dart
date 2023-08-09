import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../cubit/soccer_cubit.dart';
import '../cubit/soccer_state.dart';

class SoccerLayout extends StatelessWidget {
  const SoccerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SoccerCubit, SoccerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SoccerCubit cubit = context.read<SoccerCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              if (index == 1) {
                cubit.currentFixtures = cubit.dayFixtures;
              }
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer_rounded),
                label: AppStrings.games, // Changed fixtures to games
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: AppStrings.standings,
              ),
              BottomNavigationBarItem( // Added Odds item
                icon: Icon(Icons.insert_chart),
                label: AppStrings.odds,
              ),
              // BottomNavigationBarItem( // Added Lives item
              //   icon: Icon(Icons.live_tv),
              //   label: AppStrings.live,
              // ),
              // BottomNavigationBarItem( // Added Bookies item
              //   icon: Icon(Icons.book_online),
              //   label: AppStrings.bookies,
              // ),
            ],
            unselectedItemColor: Colors.grey, // Inactive color
            selectedItemColor: Colors.blue,   // Active color
          ),
        );
      },
    );
  }
}