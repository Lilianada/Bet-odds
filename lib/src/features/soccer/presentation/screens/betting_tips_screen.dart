import 'package:flutter/material.dart';
import 'package:resultizer/src/features/auth/presentation/screens/login_screen.dart';

class BettingTipsScreen extends StatelessWidget {
  final List<Tipster> tipsters = [
    Tipster(
      name: "Tipster A",
      imageUrl: "assets/images/liverpool.jpeg",
      category: "Soccer",
      tips: ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem R", "Tip 2"],
    ),
    Tipster(
      name: "Tipster B",
      imageUrl: "assets/images/download.jpeg",
      category: "Soccer",
      tips: ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem R", "Tip 2"],
    ),
    Tipster(
      name: "Tipster J",
      imageUrl: "assets/images/pl_completed_transfers.webp",
      category: "Soccer",
      tips: ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem R", "Tip 2"],
    ),
    Tipster(
      name: "Tipster B",
      imageUrl: "assets/images/download.jpeg",
      category: "Soccer",
      tips: ["Tip 1", "Tip 2"],
    ),
    Tipster(
      name: "Tipster Z",
      imageUrl: "assets/images/skysports-manchester-city-fernandinho_5392783.jpg",
      category: "Soccer",
      tips: ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem R", "Tip 2"],
    ),
    // Add more tipsters as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Betting Tips", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search by tipster’s name or tip category",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            // Betting tips header
            const Row(
              children: [
                Icon(Icons.lightbulb_outline),
                SizedBox(width: 8),
                Text("Betting Tips", style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 16),
            // List of Tipsters
            Expanded(
  child: ListView.builder(
    itemCount: tipsters.length,
    itemBuilder: (context, index) {
      final tipster = tipsters[index];
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(tipster.imageUrl, width: 50, height: 50),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tipster.name),
                        const SizedBox(height: 4),
                        Text(
                          tipster.category,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tipster.tips.map((tip) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      tip,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to a new page to see the full tip
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),  // Assuming all the tips are combined as a single string
                    ),
                  );
                },
                child: const Text("Read More"),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Follow"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text("Notify Me"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ),
),


          ],
        ),
      ),
    );
  }
}

class Tipster {
  final String name;
  final String imageUrl;
  final String category;
  final List<String> tips;

  Tipster({required this.name, required this.imageUrl, required this.category, required this.tips});
}
