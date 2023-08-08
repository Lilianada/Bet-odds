import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/response_status.dart';
import '../../../../core/widgets/center_indicator.dart';
import '../../../soccer/presentation/widgets/block_dialog.dart';
import '../../../soccer/presentation/widgets/view_betting_odds.dart';
import '../cubit/betting_odds_cubit.dart';
import '../cubit/betting_odds_state.dart';
import '../../../../core/utils/app_values.dart';

class BettingOddsScreen extends StatelessWidget {
  const BettingOddsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BettingOddsCubit, BettingOddsStates>(
      listener: (context, state) {
        if (state is BettingOddsLoadFailure &&
            state.message ==
                DataSource.networkConnectError.getFailure().message) {
          buildBlockAlert(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        BettingOddsCubit cubit = context.read<BettingOddsCubit>();
        return state is BettingOddsLoading
            ? centerIndicator()
            : RefreshIndicator(
                onRefresh: () async {
                  await cubit.getOdds(date: '');
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p20),
                    child: ViewBettingOdds(odds: cubit.odds),
                  ),
                ),
              );
      },
    );
  }
}
