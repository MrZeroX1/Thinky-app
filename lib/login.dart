import 'package:flutter/material.dart';
import 'package:thinky/kids_page.dart';
import 'package:thinky/parent_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _bgController;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _bgPositionAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Animation Controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _logoPositionAnimation = Tween<double>(begin: 0, end: -100).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    // Background Animation Controller
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _bgPositionAnimation = Tween<double>(
            begin: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height,
            end: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                    .size
                    .height /
                2)
        .animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeOut),
    );

    // Start animations
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await _logoController.forward();
    await _bgController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFF42A5F5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Animated Logo
          AnimatedBuilder(
            animation: _logoController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _logoPositionAnimation.value),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        'assets/robot.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Text
                    const Text(
                      "Thinky",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "AI for kids to connect and grow",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 88, 91),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Sliding Background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Positioned(
                top: _bgPositionAnimation.value,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Parents Button
                      GestureDetector(
                        onTap: () {
                          print("Parents tapped!");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ParentDashboard()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: 200, // Fixed width for both buttons
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.people_alt, size: 40),
                                  SizedBox(width: 10),
                                  Text(
                                    "Parents",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Kids Button
                      GestureDetector(
                        onTap: () {
                          print("Kids tapped!");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const KidsPage()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            width: 200, // Fixed width for both buttons
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.child_care, size: 40),
                                  SizedBox(width: 10),
                                  Text(
                                    "Kids",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
