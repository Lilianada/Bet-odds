// splash_screen.dart
import 'package:flutter/material.dart';

import '../../../config/app_constants.dart';
import '../../auth/presentation/screens/login_screen.dart';
import '../onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                 const OnboardingScreen())); // Navigates to another page after splash
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