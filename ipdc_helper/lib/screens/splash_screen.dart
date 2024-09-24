import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipdc_helper/assets.dart';
import 'package:ipdc_helper/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2, milliseconds: 500),
    )..forward();

    Future.delayed(
      const Duration(seconds: 3),
      () => context.navigator.pushReplacementNamed('/homepage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'LogoTag',
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              width: context.mediaQuery.size.width * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.onBackground,
                image: const DecorationImage(image: AssetImage(Assets.logo)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
