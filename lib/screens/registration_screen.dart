import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  DateTime? _selectedDate;
  String? _selectedState;
  String? _selectedCountry;
  String? _selectedClientType;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _firmNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alternatePersonController =
      TextEditingController();
  final TextEditingController _alternateNumberController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _panCardController = TextEditingController();
  final TextEditingController _aadharCardController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _states = [
    'Maharashtra',
    'Gujarat',
    'Karnataka',
    // Add more states
  ];

  final List<String> _countries = [
    'India',
    'United States',
    'United Kingdom',
    // Add more countries
  ];

  final List<String> _clientTypes = [
    'Individual',
    'Company',
    'Partnership',
    'Others',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _firmNameController.dispose();
    _phoneController.dispose();
    _alternatePersonController.dispose();
    _alternateNumberController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _panCardController.dispose();
    _aadharCardController.dispose();
    _gstController.dispose();
    _yearController.dispose();
    _remarkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Registration Details',
          style: TextStyle(
            color: AppTheme.primaryRed,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppTheme.primaryRed, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchRegistrationData(), // Create this method to fetch data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                title: 'Personal Information',
                items: {
                  'Full Name': data['name'] ?? 'N/A',
                  'Firm Name': data['firmName'] ?? 'N/A',
                  'Phone Number': data['phone'] ?? 'N/A',
                },
                icon: Icons.person_outline,
              ),
              _buildSection(
                title: 'Alternate Contact',
                items: {
                  'Alternate Person': data['alternatePerson'] ?? 'N/A',
                  'Alternate Number': data['alternateNumber'] ?? 'N/A',
                },
                icon: Icons.contacts_outlined,
              ),
              _buildSection(
                title: 'Address Details',
                items: {
                  'Village/City': data['city'] ?? 'N/A',
                  'District': data['district'] ?? 'N/A',
                  'State': data['state'] ?? 'N/A',
                  'Country': data['country'] ?? 'N/A',
                },
                icon: Icons.location_on_outlined,
              ),
              _buildSection(
                title: 'Account Details',
                items: {
                  'Email Address': data['email'] ?? 'N/A',
                },
                icon: Icons.account_circle_outlined,
              ),
              _buildSection(
                title: 'Document Details',
                items: {
                  'PAN Card': data['panCard'] ?? 'N/A',
                  'Aadhar Card': data['aadharCard'] ?? 'N/A',
                  'GST Number': data['gstNo'] ?? 'N/A',
                },
                icon: Icons.document_scanner_outlined,
              ),
              _buildSection(
                title: 'Additional Details',
                items: {
                  'Digital Certificate Expire Date':
                      data['certificateExpiry'] != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(data['certificateExpiry']))
                          : 'N/A',
                  'Year': data['year'] ?? 'N/A',
                  'Client Type': data['clientType'] ?? 'N/A',
                  'Remark': data['remark'] ?? 'N/A',
                  'Description': data['description'] ?? 'N/A',
                },
                icon: Icons.info_outline,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Map<String, String> items,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.primaryRed, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: items.entries.map((entry) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Text(' : '),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (entry.key != items.entries.last.key)
                    Divider(
                      height: 24,
                      color: Colors.grey[200],
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> _fetchRegistrationData() async {
    // Replace this with actual API call
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Dummy data - replace with actual API response
    return {
      'name': 'John Doe',
      'firmName': 'Tech Solutions Pvt Ltd',
      'phone': '+91 9876543210',
      'alternatePerson': 'Jane Doe',
      'alternateNumber': '+91 9876543211',
      'city': 'Mumbai',
      'district': 'Mumbai Suburban',
      'state': 'Maharashtra',
      'country': 'India',
      'email': 'john.doe@example.com',
      'panCard': 'ABCDE1234F',
      'aadharCard': '1234 5678 9012',
      'gstNo': '27ABCDE1234F1Z5',
      'certificateExpiry': '2025-12-31',
      'year': '2024',
      'clientType': 'Company',
      'remark': 'Premium Client',
      'description':
          'Tech solutions provider with focus on software development',
    };
  }
}
