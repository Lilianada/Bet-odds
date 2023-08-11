// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:odd_sprat/src/features/auth/presentation/screens/login_screen.dart';
import 'package:odd_sprat/src/features/soccer/presentation/screens/offers_screen.dart';
import 'dart:async';
import '../../../config/app_constants.dart';
import '../../auth/presentation/screens/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Timer _timer;
  int _start = 10;
  late PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(Duration.zero, () {
      startTimer();
    });

    // Start the slideshow timer
    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OffersScreen()));
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tertiary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Column(
            children: [
              const Text('Welcome to',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.background,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 16),
              const Text('Oddsprat ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.labelTextStyle,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 6),
              const Text('livescores & betting tips',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.labelTextStyle,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset('assets/images/liverpool.jpeg',
                            fit: BoxFit.cover),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                            'assets/images/pl_completed_transfers.webp',
                            fit: BoxFit.cover),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                            'assets/images/download.jpeg',
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Oddsprat is a platform that provides you with the latest football news, livescores, betting tips and predictions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.labelTextStyle,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Skipping in $_start seconds...'),
          ),
        ],
      ),
    );
  }
}
