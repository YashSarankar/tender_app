import 'package:flutter/material.dart';
import 'package:tender_app/screens/splash_screen.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:tender_app/services/auth_service.dart';
import 'package:tender_app/screens/main_screen.dart';
import 'package:tender_app/screens/login_screen.dart';

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
      home: FutureBuilder<(Map<String, dynamic>?, String?)>(
        future: AuthService().autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          
          final data = snapshot.data;
          if (data != null && data.$1 != null) {
            return const MainScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
