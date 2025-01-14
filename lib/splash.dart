import 'package:flutter/material.dart';
import 'package:thinky/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _robotController;
  late String _displayedText;
  final String _fullText = "Thinky";

  @override
  void initState() {
    super.initState();

    // Animation for the robot appearance
    _robotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _displayedText = "";

    // Start animations and navigate to main page
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await _robotController.forward();
    for (int i = 0; i < _fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _displayedText = _fullText.substring(0, i + 1);
      });
    }

    // Wait for a moment after the animations
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to the main page
    _navigateToMainPage();
  }

  void _navigateToMainPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    _robotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF42A5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Robot icon with animation
              ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: _robotController,
                    curve: Curves.easeOut,
                  ),
                ),
                child: Image.asset(
                  'assets/robot.png', // Replace with your image path
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 10), // 10px space between image and text
              // Typing text animation
              Text(
                _displayedText,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
