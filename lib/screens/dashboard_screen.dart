import 'package:flutter/material.dart';
import 'package:tender_app/models/document.dart';
import 'package:tender_app/screens/login_screen.dart';
import 'package:tender_app/widgets/document_card.dart';
import 'package:tender_app/screens/profile_screen.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'package:tender_app/services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Document> documents = [
      Document(
        title: 'Aadhar Card',
        icon: Icons.credit_card,
        status: 'Valid',
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2033, 1, 1),
      ),
      Document(
        title: 'PAN Card',
        icon: Icons.account_balance_wallet,
        status: 'Expiring Soon',
        startDate: DateTime(2023, 1, 1),
        endDate: DateTime(2024, 5, 1),
      ),
      Document(
        title: 'Voter ID',
        icon: Icons.how_to_vote,
        status: 'Not Added',
      ),
      Document(
        title: 'Driving License',
        icon: Icons.drive_eta,
        status: 'Not Added',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100], // Light gray background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryRed,
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
          IconButton(
            icon: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black54,
                  size: 24,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryRed,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black54,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your Documents',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryRed.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.primaryRed,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          documents.any((doc) => doc.status == 'Expiring Soon')
                              ? 'Some of your documents are expiring soon. Please renew them.'
                              : 'Track your document validity dates here',
                          style: TextStyle(
                            color: AppTheme.primaryRed,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: documents.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final document = documents[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        document.icon,
                        color: AppTheme.primaryRed,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      document.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: document.startDate != null
                        ? Text(
                            'Valid until ${document.endDate?.year}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          )
                        : null,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(document.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        document.status,
                        style: TextStyle(
                          color: _getStatusColor(document.status),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () {
                      // Handle document tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'valid':
        return Colors.green;
      case 'expiring soon':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      case 'not added':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
} 