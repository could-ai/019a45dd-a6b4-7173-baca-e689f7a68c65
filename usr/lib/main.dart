import 'package:couldai_user_app/screens/onboarding_screen.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GreenPulseApp());
}

class GreenPulseApp extends StatelessWidget {
  const GreenPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenPulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
