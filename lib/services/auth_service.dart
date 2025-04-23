import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserData = 'userData';
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';
  static const String baseUrl = 'https://crm.actthost.com/api';

  // Save login state and credentials
  Future<void> saveLoginState(
      Map<String, dynamic> userData, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserData, jsonEncode(userData));
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  // Auto login with saved credentials
  Future<(Map<String, dynamic>?, String?)> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_keyEmail);
    final password = prefs.getString(_keyPassword);

    if (email != null && password != null) {
      return login(email, password);
    }
    return (null, 'No saved credentials');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get saved user data
  Future<Map<String, dynamic>?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_keyUserData);
    if (userData != null) {
      return jsonDecode(userData) as Map<String, dynamic>;
    }
    return null;
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<(Map<String, dynamic>?, String?)> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login?email=$email&password=$password'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['error'] == false) {
          //save user id to shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', data['client']['id'].toString());
          final userData = data['client'] as Map<String, dynamic>;
          await saveLoginState(userData, email, password);
          return (userData, null);
        } else {
          return (null, data['message'] as String?);
        }
      } else {
        return (null, 'Server error occurred');
      }
    } catch (e) {
      return (null, 'Network error occurred');
    }
  }
}
