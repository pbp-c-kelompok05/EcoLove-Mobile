import 'package:flutter/material.dart';
import 'features/home/presentation/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoLove',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF287D35),
          surface: const Color(0xFFFAF7F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7F0),
      ),
      home: const LandingPage(),
    );
  }
}
