import 'package:flutter/material.dart';
import '../../../../config/app_constants.dart';

class OffersScreen extends StatelessWidget {
  // Dummy data for Offers
  final List<Offer> offers = [
    Offer(
        title: "Casino sports partnership",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry A",
        imageUrl: "assets/images/liverpool.jpeg"),
    Offer(
        title: "Offer B",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry B",
        imageUrl: "assets/images/download.jpeg"),
    Offer(
        title: "Offer C",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry C",
        imageUrl:
            "assets/images/skysports-manchester-city-fernandinho_5392783.jpg"),
    Offer(
        title: "Offer D",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry D",
        imageUrl: "assets/images/pl_completed_transfers.webp"),
    // Add more offers as required
  ];

  OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            Image.asset("assets/logos/Resultizer_Logo_Black1.png", fit: BoxFit.contain),
        title:
            const Text("Offers", style: TextStyle(color: AppColors.background)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 05.0), // Spaces out items vertically
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0), // Adds padding inside each item
                    leading: Image.asset(offer.imageUrl,
                        width: 70, height: 70, fit: BoxFit.cover),
                    title: Text(offer.title),
                    subtitle: Text(
                      offer.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.background),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: AppColors.grey, size: 16),
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

class Offer {
  final String title;
  final String description;
  final String imageUrl;

  Offer(
      {required this.title, required this.description, required this.imageUrl});
}
