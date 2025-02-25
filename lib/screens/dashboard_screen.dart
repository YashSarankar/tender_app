import 'package:flutter/material.dart';
import 'package:tender_app/models/document.dart';
import 'package:tender_app/screens/login_screen.dart';
import 'package:tender_app/widgets/document_card.dart';
import 'package:tender_app/screens/profile_screen.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:tender_app/services/auth_service.dart';
import 'package:tender_app/screens/documents_screen.dart';
import 'package:tender_app/screens/enquiry_screen.dart';
import 'package:tender_app/screens/notifications_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Image.asset(
                'assets/logo-removebg-preview.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black54,
                size: 24,
              ),
              onPressed: () async {
                await AuthService().logout();
                if (!mounted) return;
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.dashboard_rounded,
                          color: AppTheme.primaryRed,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Dashboard Overview',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final items = [
                        {
                          'title': 'All Digital Signature',
                          'count': '3',
                          'icon': Icons.verified_rounded,
                          'color': const Color(0xFF4CAF50),
                          'bgColor': const Color(0xFFE8F5E9),
                          'isDigital': true,
                        },
                        {
                          'title': 'Near to Expire Digital Signature',
                          'count': '0',
                          'icon': Icons.timer_rounded,
                          'color': const Color(0xFFFFA000),
                          'bgColor': const Color(0xFFFFF3E0),
                          'isDigital': true,
                        },
                        {
                          'title': 'Expired Digital Signature',
                          'count': '2',
                          'icon': Icons.warning_rounded,
                          'color': const Color(0xFFF44336),
                          'bgColor': const Color(0xFFFFEBEE),
                          'isDigital': true,
                        },
                        {
                          'title': 'Expired Documents',
                          'count': '0',
                          'icon': Icons.description_rounded,
                          'color': const Color(0xFF2196F3),
                          'bgColor': const Color(0xFFE3F2FD),
                          'isDigital': false,
                        },
                        {
                          'title': 'Near to Expire Documents',
                          'count': '0',
                          'icon': Icons.timer_rounded,
                          'color': const Color(0xFF9C27B0),
                          'bgColor': const Color(0xFFF3E5F5),
                          'isDigital': false,
                        },
                      ];

                      final item = items[index];
                      return _buildStatsCard(
                        title: item['title'] as String,
                        count: item['count'] as String,
                        icon: item['icon'] as IconData,
                        color: item['color'] as Color,
                        bgColor: item['bgColor'] as Color,
                        isDigital: item['isDigital'] as bool,
                        onTap: () => print('${item['title']} tapped'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required bool isDigital,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isDigital ? 'see all' : 'see details',
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 