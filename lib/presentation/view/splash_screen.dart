import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/colors.dart';
import '../../core/constants/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  double _scale = 0.8;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1;
        _scale = 1;
      });
      _navigateNext();
    });
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, AppColors.primaryLight],
              ),
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColors.primaryLight, Colors.transparent],
              ),
            ),
          ),

          Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Care4Me',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
