import 'package:flutter/material.dart';
import '../../../../core/domain/entities/betting_odds.dart';
import '../../../../core/utils/app_strings.dart';


class ViewBettingOdds extends StatelessWidget {
  final List<BettingOdds> odds;

  const ViewBettingOdds({Key? key, required this.odds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (odds.isEmpty) {
      return const SizedBox();
    }
    return DataTable(
      columns: const [
        DataColumn(
          label: Text(AppStrings.homeTeam),
        ),
        DataColumn(
          label: Text(AppStrings.awayTeam),
        ),
        DataColumn(
          label: Text(AppStrings.odds),
        ),
      ],
      rows: odds
          .map((odd) => DataRow(cells: [
                DataCell(Text(odd.homeTeam)),
                DataCell(Text(odd.awayTeam)),
                DataCell(Text('${odd.homeOdds}')),
              ]))
          .toList(),
    );
  }
}