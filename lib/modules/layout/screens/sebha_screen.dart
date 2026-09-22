import 'package:flutter/material.dart';
import 'package:islam_c20_online/core/theme/app_colors.dart';


class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  static const int _target = 33;

  static const List<String> _dhikrList = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
  ];

  int _counter = 0;
  int _dhikrIndex = 0;
  double _rotationTurns = 0.0;

  void _onTapBead() {
    setState(() {
      _counter++;
      // كل خرزة = جزء من الدورة الكاملة
      _rotationTurns += 1 / _target;

      if (_counter >= _target) {
        _counter = 0;
        _dhikrIndex = (_dhikrIndex + 1) % _dhikrList.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double ringSize = screenWidth * 379 / 431;
    final double logoWidth = screenWidth * 291 / 431;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/sebha/Sebha_Background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/sebha/sebha_header.png", width: logoWidth),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  // اتظبط بالظبط على أرقام فيجما: Size 36 - Weight 700 - Line height 100% - Letter spacing 0
                  color: AppColors.white,
                  fontFamily: "Janna LT",
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _onTapBead,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: ringSize,
                height: ringSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [

                    AnimatedRotation(
                      turns: _rotationTurns,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Image.asset(
                        "assets/sebha/sebha_ring_only.png",
                        width: ringSize,
                        height: ringSize,
                      ),
                    ),

                    Positioned(
                      top: -78,
                      left: 170,
                      child: Image.asset(
                        "assets/sebha/sebha_head_only.png",
                        width: 70,
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _dhikrList[_dhikrIndex],
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: "Janna LT",
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$_counter',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 36,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 92),
          ],
        ),
      ),
    );
  }
}