// import 'package:flutter/material.dart';

// class FlashScoreNews extends StatelessWidget {
//   final List<NewsItem> newsItems;

//   const FlashScoreNews({Key? key, required this.newsItems}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Flash Score News",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           ...newsItems.map((news) => Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: Text(
//                   news.headline,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }

// class NewsItem {
//   final String headline;

//   NewsItem({required this.headline, required String imageUrl});
// }

// // Sample Usage
// class BettingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Dummy news data
//     List<NewsItem> dummyNews = [
//       NewsItem(headline: "Team A signs a new player!"),
//       NewsItem(headline: "Team B wins the championship!"),
//       NewsItem(headline: "Star player injured in yesterday's match."),
//     ];

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Existing BettingOddsView widget
//             // ...

//             // Flash Score News component
//             FlashScoreNews(newsItems: dummyNews),
//           ],
//         ),
//       ),
//     );
//   }
// }
