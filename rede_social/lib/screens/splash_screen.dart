// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 180,
              height: 180,
            ).animate().fadeIn(duration: 2000.ms).scale(delay: 500.ms, duration: 1500.ms),
            const SizedBox(height: 30),
            Text(
              'SENN Connect',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
                letterSpacing: 4,
                shadows: [
                  const Shadow(
                    color: Colors.black87,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
            ).animate().fadeIn(delay: 1500.ms, duration: 1000.ms),
          ],
        ),
      ),
    );
  }
}
