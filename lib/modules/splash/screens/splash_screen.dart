import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/layout/screens/layout_screen.dart';
import 'package:islam_c20_online/modules/splash/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    final bool onboardingSeen =
        prefs.getBool('onboarding_seen') ?? false;

    if (!mounted) return;

    if (onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LayoutScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/logo/app_logo.png",
                ),
              ),
            ),

            Center(
              child: Image.asset(
                "assets/logo/route_logo.png",
                width: 244,
              ),
            ),
          ],
        ),
      ),
    );
  }
}