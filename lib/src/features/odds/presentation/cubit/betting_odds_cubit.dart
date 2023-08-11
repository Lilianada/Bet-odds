import 'package:bloc/bloc.dart';
import 'package:live_score/src/core/utils/app_strings.dart';

import '../../../../core/domain/entities/betting_odds.dart';
import '../../domain/use_cases/get_betting_odds.dart';
import 'betting_odds_state.dart';

class BettingOddsCubit extends Cubit<BettingOddsStates> {
  final GetBettingOddsUseCase getBettingOddsUseCase;

  BettingOddsCubit({required this.getBettingOddsUseCase})
      : super(BettingOddsInitial());

  List<String> titles = [
    AppStrings.odds,
  ];

  List<BettingOdds> odds = [];

  Future<void> getOdds({required String date}) async {
    emit(BettingOddsLoading());
    final result = await getBettingOddsUseCase(date);

    result.fold(
      (left) {
        emit(BettingOddsLoadFailure(left.message));
      },
      (right) {
        odds = right;
        emit(BettingOddsLoaded(odds));
      },
    );
  }
}
