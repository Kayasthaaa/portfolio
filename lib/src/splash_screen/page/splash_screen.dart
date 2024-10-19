// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:portfolio/src/portfolio_content/page/portfolio_content.dart';
import 'package:portfolio/src/splash_screen/widgets/splash_painter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late Animation<double> _lineToCircleAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 5500),
      vsync: this,
    );

    _lineToCircleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0, 0.5, curve: Curves.easeInOutCubic),
      ),
    );

    _particleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeInOutCubic),
      ),
    );

    _slideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.8, 1, curve: Curves.easeOutCubic),
      ),
    );

    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _mainController,
            builder: (context, child) {
              return CustomPaint(
                painter: SplashPainter(
                  lineToCircleProgress: _lineToCircleAnimation.value,
                  particleProgress: _particleAnimation.value,
                ),
                size: Size.infinite,
              );
            },
          ),
          AnimatedBuilder(
            animation: _mainController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0,
                    MediaQuery.of(context).size.height * _slideAnimation.value),
                child: const PortfolioContent(),
              );
            },
          ),
        ],
      ),
    );
  }
}
