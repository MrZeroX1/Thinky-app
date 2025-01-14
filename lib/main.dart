import 'package:flutter/material.dart';
import 'package:thinky/splash.dart';
import 'package:provider/provider.dart';
import 'package:thinky/progress_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProgressState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Thinky App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage());
  }
}
