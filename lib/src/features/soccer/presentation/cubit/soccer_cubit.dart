import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/features/odds/presentation/screens/betting_odds_screen.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/league_of_fixture.dart';
import '../../domain/use_cases/day_fixtures_usecase.dart';
import '../../domain/use_cases/leagues_usecase.dart';
import '../../domain/use_cases/live_fixtures_usecase.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../screens/fixtures_screen.dart';
import '../screens/soccer_screen.dart';
import '../screens/standings_screen.dart';
import 'soccer_state.dart';

class SoccerCubit extends Cubit<SoccerStates> {
  final DayFixturesUseCase dayFixturesUseCase;
  final LeaguesUseCase leaguesUseCase;
  final LiveFixturesUseCase liveFixturesUseCase;
  final StandingsUseCase standingUseCase;

  SoccerCubit({
    required this.dayFixturesUseCase,
    required this.leaguesUseCase,
    required this.liveFixturesUseCase,
    required this.standingUseCase,
  }) : super(ScoreInitial());

  List screens = [
    const SoccerScreen(),
    const FixturesScreen(),
    const StandingsScreen(),
    const BettingOddsScreen(),
  ];

  List<String> titles = [
    AppStrings.liveScore,
    AppStrings.fixtures,
    AppStrings.standings,
    AppStrings.odds,
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SoccerChangeBottomNav());
  }

  List<League> filteredLeagues = [];

  Future<List<League>> getLeagues() async {
    emit(SoccerLeaguesLoading());
    
    try {
        final leaguesResult = await leaguesUseCase(NoParams());
        
        // Print the result from the leaguesUseCase
        print("Received leagues result: $leaguesResult");
        
        // Assuming leaguesResult is either a Left or Right type, e.g., from Dartz package
        if (leaguesResult.isRight()) {
            final leagues = leaguesResult.getOrElse(() => []);
            
            // Print the processed leagues
            print("Processed leagues: $leagues");
            
            for (League league in leagues) {
                filteredLeagues.add(league);
                AppConstants.leaguesFixtures
                    .putIfAbsent(league.id, () => LeagueOfFixture(league: league));
            }
            emit(SoccerLeaguesLoaded(filteredLeagues));
        } else {
            emit(SoccerLeaguesLoadFailure(leaguesResult.fold((l) => l.message, (r) => '')));
        }
    } catch (error) {
        // Print any errors
        print("Error in getLeagues: $error");
        emit(SoccerLeaguesLoadFailure(error.toString()));
    }
    
    return filteredLeagues;
}


  List<SoccerFixture> dayFixtures = [];

  Future<List<SoccerFixture>> getFixtures() async {
    emit(SoccerFixturesLoading());
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final fixturesEither = await dayFixturesUseCase(date);
    List<SoccerFixture> fixtures = fixturesEither.fold(
      (failure) {
        emit(SoccerFixturesLoadFailure(failure.message));
        return <SoccerFixture>[];
      },
      (fixtureList) {
        AppConstants.leaguesFixtures.forEach((key, value) {
          value.fixtures.clear();
        });
        for (SoccerFixture fixture in fixtureList) {
          dayFixtures.add(fixture);
          if (AppConstants.leaguesFixtures[fixture.fixtureLeague.id] != null) {
            AppConstants.leaguesFixtures[fixture.fixtureLeague.id]!.fixtures
                .add(fixture);
          }
        }
        emit(SoccerFixturesLoaded(dayFixtures));
        return fixtureList;
      },
    );
    return fixtures;
  }

  Future<List<SoccerFixture>> getLiveFixtures() async {
    emit(SoccerFixturesLoading());
    final liveFixturesEither = await liveFixturesUseCase(NoParams());
    List<SoccerFixture> liveFixtures = liveFixturesEither.fold(
      (failure) {
        emit(SoccerLiveFixturesLoadFailure(failure.message));
        return <SoccerFixture>[];
      },
      (fixtureList) {
        emit(SoccerLiveFixturesLoaded(fixtureList));
        return fixtureList;
      },
    );
    return liveFixtures;
  }

  List<SoccerFixture> currentFixtures = [];

  loadCurrentFixtures(int leagueId) {
    currentFixtures = AppConstants.leaguesFixtures[leagueId]?.fixtures ?? [];
    emit(SoccerCurrentFixturesChanges());
  }

  Future<void> getStandings(StandingsParams params) async {
    emit(SoccerStandingsLoading());
    final standings = await standingUseCase(params);
    standings.fold(
      (left) => emit(SoccerStandingsLoadFailure(left.message)),
      (right) {
        emit(SoccerStandingsLoaded(right));
      },
    );
  }

  Future<void> resetFilters() async {
    filteredLeagues = [];
    AppConstants.leaguesFixtures.clear();
    final leagues = await leaguesUseCase(NoParams());
    leagues.fold(
      (left) => emit(SoccerLeaguesLoadFailure(left.message)),
      (right) {
        for (League league in right) {
          if (AppConstants.availableLeagues.contains(league.id)) {
            filteredLeagues.add(league);
            AppConstants.leaguesFixtures
                .putIfAbsent(league.id, () => LeagueOfFixture(league: league));
          }
        }
        emit(SoccerLeaguesLoaded(filteredLeagues));
      },
    );
  }
}
