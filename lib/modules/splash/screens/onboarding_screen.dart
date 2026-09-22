import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';
import 'package:islam_c20_online/modules/layout/screens/layout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// موديل بسيط لكل صفحة onboarding
class _OnboardingItem {
  final String image;
  final String? title;
  final String subtitle;

  const _OnboardingItem({
    required this.image,
    this.title,
    required this.subtitle,
  });
}

// أسامي الصور الحقيقية من assets/onboarding/
const List<_OnboardingItem> _items = [
  _OnboardingItem(
    image: "assets/onboarding/welcome_calligraphy.png",
    subtitle: "Welcome To Islmi App",
  ),
  _OnboardingItem(
    image: "assets/onboarding/mosque.png",
    title: "Welcome To Islami",
    subtitle: "We Are Very Excited To Have You In Our Community",
  ),
  _OnboardingItem(
    image: "assets/onboarding/quran.png",
    title: "Reading the Quran",
    subtitle: "Read, and your Lord is the Most Generous",
  ),
  _OnboardingItem(
    image: "assets/onboarding/praying_hands.png",
    title: "Bearish",
    subtitle: "Praise the name of your Lord, the Most High",
  ),
  _OnboardingItem(
    image: "assets/onboarding/radio_mic.png",
    title: "Holy Quran Radio",
    subtitle:
    "You can listen to the Holy Quran Radio through the application for free and easily",
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  bool get _isLastPage => _currentIndex == _items.length - 1;
  bool get _isFirstPage => _currentIndex == 0;

  void _goNext() {
    if (_isLastPage) {
      _finish();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goBack() {
    if (_isFirstPage) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('onboarding_seen', true);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LayoutScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),

                          Image.asset(
                            "assets/logo/home_logo.png",
                            width: 291,
                          ),

                          const SizedBox(height: 40),

                          SizedBox(
                            width: double.infinity,
                            height: 415,
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                            ),
                          ),

                          const SizedBox(height: 40),

                          if (item.title != null) ...[
                            Text(
                              item.title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 40),
                          ],

                          Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.gold,
                              fontFamily: "Janna LT",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              height: 1.0,
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                  },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: _isFirstPage
                        ? null
                        : TextButton(
                      onPressed: _goBack,
                      child: Text(
                        "Back",
                        style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _items.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: index == _currentIndex ? 20 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: index == _currentIndex
                                ? AppColors.gold
                                : AppColors.white.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: TextButton(
                      onPressed: _goNext,
                      child: Text(
                        _isLastPage ? "Finish" : "Next",
                        style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}