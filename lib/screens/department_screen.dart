import 'package:flutter/material.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Department Details',
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
        future: _fetchDepartmentData(),
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
                title: 'Basic Information',
                icon: Icons.person_outline,
                items: {
                  'Name': data['name'] ?? 'N/A',
                  'Mobile': data['mobile'] ?? 'N/A',
                  'Second Mobile No': data['secondMobile'] ?? 'N/A',
                  'E-mail': data['email'] ?? 'N/A',
                  'Alternate Person Name': data['alternatePerson'] ?? 'N/A',
                  'Alternate Person Number': data['alternateNumber'] ?? 'N/A',
                  'Aadhar Number': data['aadharNumber'] ?? 'N/A',
                  'PAN Number': data['panNumber'] ?? 'N/A',
                },
              ),
              _buildSection(
                title: 'Department',
                icon: Icons.business_outlined,
                items: {
                  'Department Name': data['departmentName'] ?? 'N/A',
                },
              ),
              _buildSection(
                title: 'Digital Signature',
                icon: Icons.verified_user_outlined,
                items: {
                  'DSC Expired Date': _formatDate(data['dscExpiredDate']),
                  'Year': data['year'] ?? 'N/A',
                  'Remark': data['remark'] ?? 'N/A',
                },
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Map<String, String> items,
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
                        width: 140,
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

  Widget _buildPortalSection({
    required String title,
    required IconData icon,
    required List<dynamic> portalDetails,
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
        ...portalDetails.map((portal) => _buildPortalDetailsCard(
              portalName: portal['name'],
              portalId: portal['id'],
              portalPassword: portal['password'],
            )),
      ],
    );
  }

  Widget _buildPortalDetailsCard({
    required String portalName,
    required String portalId,
    required String portalPassword,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryRed.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryRed.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.web_outlined,
                color: AppTheme.primaryRed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                portalName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPortalDetailRow('Portal ID', portalId),
          const SizedBox(height: 8),
          _buildPortalDetailRow('Password', portalPassword, isPassword: true),
        ],
      ),
    );
  }

  Widget _buildPortalDetailRow(String label, String value,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reduce width and ensure text wraps properly
          SizedBox(
            width: 80, // Reduced from 100
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(' : '),
          // Wrap the value section in Expanded to prevent overflow
          Expanded(
            child: Row(
              children: [
                // Wrap the text in Expanded to allow text wrapping
                Expanded(
                  child: Text(
                    isPassword ? '••••••••' : value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (isPassword) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      // Add show/hide password logic
                    },
                    child: Icon(
                      Icons.visibility_outlined,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchDepartmentData() async {
    // Replace this with actual API call
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Dummy data - replace with actual API response
    return {
      'name': 'Dipendra Singh Rathore',
      'mobile': '9876543210',
      'secondMobile': '9876543211',
      'email': 'dipendrasingh.election@gmail.com',
      'alternatePerson': 'John Doe',
      'alternateNumber': '9876543212',
      'aadharNumber': '1234 5678 9012',
      'panNumber': 'ABCDE1234F',
      'departmentName': 'District Collectorate- Ptg',
      'dscExpiredDate': '2026-02-28',
      'year': '2 year',
      'remark': 'Active member',
      'portalDetails': [
        {
          'name': 'Eproc Rajasthan',
          'id': 'dipendrasingh.election@gmail.com',
          'password': 'Admin@123'
        }
      ],
    };
  }
}
