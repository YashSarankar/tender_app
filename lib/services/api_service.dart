import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://crm.actthost.com/api';

  Future<bool> submitEnquiry({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/enquiry'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'email': email,
          'mobile_no': phone,
          'subject': subject,
          'message': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to submit enquiry');
      }
    } catch (e) {
      throw Exception('Failed to submit enquiry: $e');
    }
  }
} 