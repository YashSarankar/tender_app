import 'package:flutter/material.dart';

class AppTheme {
  // Define brand colors
  static const Color primaryBlue = Color(0xFF2B3990); // Logo blue
  static const Color primaryRed = Color(0xFFE31E24);  // Logo red
  
  static final lightTheme = ThemeData(
    primaryColor: primaryRed,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    
    // App Bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    
    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    // Floating Action Button theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    
    // Card theme
    cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      shadowColor: primaryRed.withOpacity(0.2),
    ),
    
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryRed.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryRed, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryRed.withOpacity(0.2)),
      ),
      prefixIconColor: primaryRed,
    ),
    
    // Text theme
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: primaryRed,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: primaryRed,
        fontWeight: FontWeight.bold,
      ),
    ),
    
    // Icon theme
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
} 