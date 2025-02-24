import 'package:flutter/material.dart';
import 'package:tender_app/screens/splash_screen.dart';
import 'package:tender_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tender App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryRed),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
