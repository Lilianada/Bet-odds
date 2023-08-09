import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'soccer_match_status.dart';

class MatchStatus extends StatelessWidget {
  final SoccerMatchStatus status;
  final String date;
  final String homeTeam;
  final String awayTeam;

  MatchStatus(this.status, this.date, this.homeTeam, this.awayTeam);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${status.long}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
            "${homeTeam} ${status.score} - ${awayTeam}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
