// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:odd_sprat/src/config/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
        const Duration(seconds: 3)); // 3 seconds delay for splash
    // ignore: use_build_context_synchronously
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(
        context, Routes.onboarding); // Navigates to another page after splash
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Oddsprat_Logo.png',
              height: 150,
            ),
            Text(
              'Live scores & betting tips',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
