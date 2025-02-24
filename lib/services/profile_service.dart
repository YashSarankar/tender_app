import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class ProfileService {
  static const String baseUrl = 'https://crm.actthost.com/api';

  Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id') ?? '251'; // Default to 251 if not found

    final response = await http.get(
      Uri.parse('$baseUrl/get-user-profile?user_id=$userId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error'] == false) {
        return UserProfile.fromJson(data['client']);
      }
    }
    throw Exception('Failed to load profile');
  }
} 