import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_constants.dart';

class BookmakersApp extends StatelessWidget {
  const BookmakersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookmakersScreen(),
    );
  }
}
class BookmakersScreen extends StatelessWidget {
  // Dummy data for Bookmakers
  final List<Bookmaker> bookmakers = [
    Bookmaker(name: "Bookmaker A", description: "Description A", imageUrl: "assets/images/liverpool.jpeg"),
    Bookmaker(name: "Bookmaker B", description: "Description B", imageUrl: "assets/images/download.jpeg"),
    Bookmaker(name: "Bookmaker C", description: "Description C", imageUrl: "assets/images/skysports-manchester-city-fernandinho_5392783.jpg"),
    Bookmaker(name: "Bookmaker D", description: "Description D", imageUrl: "assets/images/pl_completed_transfers.webp"),
  ];

  BookmakersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matchDate = DateTime.now();
    const matchTime = "3:00 PM";
    const venue = "Stadium A";

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/logos/Resultizer_Logo_Black1.png", fit: BoxFit.contain),
        title: const Text("Bookmakers", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // The header card
          Card(
            margin: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(bookmakers[0].imageUrl, width: 40, height: 40, fit: BoxFit.cover),
                      const SizedBox(width: 8),
                      Expanded(child: Text(bookmakers[0].name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(bookmakers[0].description),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat.yMMMd().format(matchDate), style: const TextStyle(fontWeight: FontWeight.w500)),
                      const Text(matchTime, style: TextStyle(fontWeight: FontWeight.w500)),
                      const Text(venue, style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // The ListView for the rest of the bookmakers
          Expanded(
            child: ListView.builder(
              itemCount: bookmakers.length - 1,  // We've already displayed the first bookmaker in the header
              itemBuilder: (context, index) {
                final bookmaker = bookmakers[index + 1];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(bookmaker.imageUrl, height: 100),
                    title: Text(bookmaker.name),
                    subtitle: Text(bookmaker.description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Bookmaker {
  final String name;
  final String description;
  final String imageUrl;

  Bookmaker({required this.name, required this.description, required this.imageUrl});
}