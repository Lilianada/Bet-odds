import 'package:bloc/bloc.dart';
import 'package:live_score/src/core/utils/app_strings.dart';
import 'package:live_score/src/features/odds/presentation/screens/betting_odds_screen.dart';

import '../../../../core/domain/entities/betting_odds.dart';
import '../../domain/repositories/betting_odds_repository.dart';
import '../../domain/use_cases/get_betting_odds.dart';
import 'betting_odds_state.dart';

class BettingOddsCubit extends Cubit<BettingOddsStates> {
  final GetBettingOdds getBettingOdds;
  final BettingOddsRepository bettingOddsRepository;

  BettingOddsCubit( {
    required this.getBettingOdds,
    required this.bettingOddsRepository,
  }) : super(BettingOddsInitial());

  List screens = [
    const BettingOddsScreen(),
  ];

  List<String> titles = [
    AppStrings.odds,
  ];

  List<BettingOdds> odds = [];

  Future<void> getOdds({required String date}) async {
    emit(BettingOddsLoading());
    final result = await getBettingOdds(date);
    result.fold(
      (left) => emit(BettingOddsLoadFailure(left.message)),
      (right) {
        odds = right;
        emit(BettingOddsLoaded(odds));
      },
    );
  }
}