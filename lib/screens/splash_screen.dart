import 'package:flutter/material.dart';
import 'package:tender_app/screens/dashboard_screen.dart';
import 'package:tender_app/screens/login_screen.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:tender_app/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    print('Starting navigation delay');
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;

    print('Attempting auto login');
    final authService = AuthService();
    final (client, error) = await authService.autoLogin();
    
    if (!mounted) return;
    print('Auto login result - Client: ${client != null}, Error: $error');

    if (client != null) {
      print('Navigating to Dashboard');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
      );
    } else {
      print('Navigating to Login');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Design
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.primaryRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.primaryRed.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child:Padding(padding: EdgeInsets.all(20),
                    child: Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/logo-removebg-preview.png',
                        height: 150,
                      ),
                    ),
                    ),
                ),
                ),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'Tender News India',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your Trusted Tender Partner',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryRed),
                          strokeWidth: 3,
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 