import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(flex: 2),
              Icon(
                Icons.eco,
                size: 120,
                color: AppTheme.neonAccent.withOpacity(0.8),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome to GreenPulse",
                style: textTheme.displayLarge?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Nurturing plants, building communities. Your journey to a greener world starts now.",
                style: textTheme.bodyLarge?.copyWith(color: AppTheme.mutedCream),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text("Let's Grow"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
