import 'package:flutter/material.dart';
import 'package:tender_app/screens/dashboard_screen.dart';
import 'package:tender_app/screens/department_screen.dart';
import 'package:tender_app/screens/documents_screen.dart';
import 'package:tender_app/screens/enquiry_screen.dart';
import 'package:tender_app/screens/notifications_screen.dart';
import 'package:tender_app/screens/profile_screen.dart';
import 'package:tender_app/screens/registration_screen.dart';
import 'package:tender_app/screens/stp_screen.dart';
import 'package:tender_app/theme/app_theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const DocumentsScreen(),
    const SizedBox(), // Placeholder for bottom sheet button
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  void _showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                height: 4,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.grid_view_rounded,
                        color: AppTheme.primaryRed,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final List<Map<String, dynamic>> items = [
                    {
                      'title': 'Registration',
                      'subtitle': 'Manage your registrations',
                      'icon': Icons.app_registration_rounded,
                      'gradient': [
                        const Color(0xFFE3F2FD),
                        const Color(0xFFBBDEFB),
                      ],
                      'iconColor': const Color(0xFF1976D2),
                    },
                    {
                      'title': 'Department',
                      'subtitle': 'View department details',
                      'icon': Icons.business_rounded,
                      'gradient': [
                        const Color(0xFFF3E5F5),
                        const Color(0xFFE1BEE7),
                      ],
                      'iconColor': const Color(0xFF7B1FA2),
                    },
                    {
                      'title': 'STP',
                      'subtitle': 'View STP details', // Updated subtitle
                      'icon': Icons
                          .description_rounded, // Changed icon from settings to description
                      'gradient': [
                        const Color(0xFFFBE9E7),
                        const Color(0xFFFFCCBC),
                      ],
                      'iconColor': const Color(0xFFE64A19),
                    },
                  ];

                  final item = items[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (item['title'] == 'Department') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DepartmentScreen(),
                            ),
                          );
                        }
                        if (item['title'] == 'STP') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const STPScreen(),
                            ),
                          );
                        }
                        if (item['title'] == 'Registration') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        }
                        // Add navigation logic here
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: item['gradient'],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item['icon'],
                                color: item['iconColor'],
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['subtitle'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.black87.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      _showOptionsBottomSheet();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          height: 60, // Reduced from 65
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 6), // Reduced vertical padding
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  child: _buildNavItem(
                      0, Icons.home_outlined, Icons.home_rounded, 'Home')),
              Expanded(
                  child: _buildNavItem(
                      1,
                      Icons.document_scanner_outlined,
                      Icons.document_scanner_rounded,
                      'Docs')), // Shortened label
              const SizedBox(width: 8),
              _buildCenterButton(),
              const SizedBox(width: 8),
              Expanded(
                  child: _buildNavItem(
                      3,
                      Icons.notifications_outlined,
                      Icons.notifications_rounded,
                      'Alerts')), // Shortened label
              Expanded(
                  child: _buildNavItem(4, Icons.person_outline_rounded,
                      Icons.person_rounded, 'Profile')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48, // Fixed height for nav item
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              MainAxisAlignment.center, // Center items vertically
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(6), // Reduced padding
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryRed.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppTheme.primaryRed : Colors.grey[600],
                size: 20, // Reduced size
              ),
            ),
            const SizedBox(height: 1), // Minimal spacing
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryRed : Colors.grey[600],
                fontSize: 10, // Smaller font size
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return SizedBox(
      width: 44, // Reduced from 48
      height: 44, // Reduced from 48
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryRed.withOpacity(0.9),
              AppTheme.primaryRed,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryRed.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onItemTapped(2),
            borderRadius: BorderRadius.circular(14),
            child: const Icon(
              Icons.grid_view_rounded,
              color: Colors.white,
              size: 20, // Smaller icon size
            ),
          ),
        ),
      ),
    );
  }
}
