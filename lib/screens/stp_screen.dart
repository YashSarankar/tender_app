import 'package:flutter/material.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class STPScreen extends StatefulWidget {
  const STPScreen({super.key});

  @override
  State<STPScreen> createState() => _STPScreenState();
}

class _STPScreenState extends State<STPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'STP Details',
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
        future: _fetchSTPData(),
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
                title: 'Company Information',
                icon: Icons.business_outlined,
                items: {
                  'Name of Firm': data['firmName'] ?? 'N/A',
                  'Client': data['clientName'] ?? 'N/A',
                },
              ),
              _buildSection(
                title: 'Work Details',
                icon: Icons.work_outline,
                items: {
                  'Work Order No': data['workOrderNo'] ?? 'N/A',
                  'Name of Work': data['workName'] ?? 'N/A',
                  'Department': data['department'] ?? 'N/A',
                },
              ),
              _buildSection(
                title: 'Important Dates',
                icon: Icons.calendar_today_outlined,
                items: {
                  'Work Order Date': _formatDate(data['workOrderDate']),
                  'Expire Date': _formatDate(data['expireDate']),
                  'Dispatch Date': _formatDate(data['dispatchDate']),
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

  Future<Map<String, dynamic>> _fetchSTPData() async {
    // Replace this with actual API call
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Dummy data - replace with actual API response
    return {
      'firmName': 'M/s Bharat Mata Stone Crusher',
      'clientName': 'Gopal Kumawat',
      'workOrderNo': 'a213123sd',
      'workName': 'Ass',
      'department': 'District Collectorate- Ptg',
      'workOrderDate': '2025-04-13',
      'expireDate': '2026-04-13',
      'dispatchDate': '2025-04-14',
    };
  }
}
