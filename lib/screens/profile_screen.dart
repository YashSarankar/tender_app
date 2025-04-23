import 'package:flutter/material.dart';
import 'package:tender_app/screens/enquiry_screen.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final ProfileService _profileService = ProfileService();
  late Future<UserProfile> _profileFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getUserProfile();
    _tabController =
        TabController(length: 6, vsync: this); // Changed from 5 to 6
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Define color constants
  static const Color primaryRed = Color(0xFFE53935);
  static const Color lightRed = Color(0xFFFBE9E7);
  static const Color darkRed = Color(0xFFC62828);
  static const Color surfaceColor = Colors.white;
  static const Color tabBackgroundColor = Color(0xFFFAFAFA);
  static const Color selectedTabColor = primaryRed;
  static const Color unselectedTabColor = Color(0xFF757575);
  static const Color gradientStart = Color(0xFFE53935);
  static const Color gradientEnd = Color(0xFFC62828);
  static const Color selectedTextColor = Colors.white;
  static const Color tabShadowColor = Color(0xFFFFCDD2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: primaryRed),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EnquiryScreen(),
                  ));
            },
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('PROFILE',
            style: TextStyle(
              color: primaryRed,
              fontSize: 18, // Reduced from 20
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )),
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryRed),
      ),
      body: FutureBuilder<UserProfile>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final profile = snapshot.data!;
          return Column(
            children: [
              // Profile Header Section - More compact
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16), // Reduced padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40, // Reduced from 50
                      backgroundColor: lightRed,
                      backgroundImage: profile.clientImage != null
                          ? NetworkImage(profile.clientImage!)
                          : null,
                      child: profile.clientImage == null
                          ? const Icon(Icons.person,
                              size: 40, color: primaryRed)
                          : null,
                    ),
                    const SizedBox(height: 8), // Reduced spacing
                    Text(
                      profile.clientName ?? '',
                      style: const TextStyle(
                        fontSize: 20, // Reduced from 24
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    Text(
                      profile.emailId ?? '',
                      style: TextStyle(
                        fontSize: 14, // Reduced from 16
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        // Remove the Border decoration that was creating the line
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: _tabController,
                              isScrollable: true,
                              labelColor: selectedTextColor,
                              unselectedLabelColor: unselectedTabColor,
                              indicator: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [gradientStart, gradientEnd],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: tabShadowColor.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              indicatorPadding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 4), // Reduced from 4 horizontal
                              labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                              padding: EdgeInsets
                                  .zero, // Remove padding to align with start
                              physics:
                                  const BouncingScrollPhysics(), // Add smooth scrolling
                              indicatorSize: TabBarIndicatorSize.label,
                              tabAlignment:
                                  TabAlignment.start, // Align tabs to start
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 8), // Reduced from 16
                              tabs: [
                                _buildModernTab(
                                    Icons.dashboard_outlined, 'Overview'),
                                _buildModernTab(Icons.card_membership_outlined,
                                    'Registrations'),
                                _buildModernTab(
                                    Icons.web_outlined, 'Portal IDs'),
                                _buildModernTab(Icons.account_balance_outlined,
                                    'Net Banking'),
                                _buildModernTab(Icons.description_outlined,
                                    'Important Doc'),
                                _buildModernTab(Icons.verified_user_outlined,
                                    'Digital Signature'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tab View Content
              Expanded(
                child: TabBarView(
                  clipBehavior: Clip.none,
                  controller: _tabController,
                  physics:
                      const BouncingScrollPhysics(), // Add smooth scrolling
                  children: [
                    // Overview Tab
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          _buildCompactInfoCard(
                            title: 'Business Information',
                            icon: Icons.business,
                            items: {
                              'Firm Name': profile.firmName,
                              'GST No.': profile.gstNo,
                              'PAN Card': profile.panCard,
                              'Aadhar Card': profile.aadharCard,
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildCompactInfoCard(
                            title: 'Address Details',
                            icon: Icons.location_on,
                            items: {
                              'Address': profile.clientAddress,
                              'City': profile.city,
                              'District': profile.district,
                              'State': profile.state,
                              'Country': profile.country,
                            },
                          ),
                          // const SizedBox(height: 12),
                          // _buildCompactInfoCard(
                          //   title: 'Additional Details',
                          //   icon: Icons.info,
                          //   items: {
                          //     'Client ID': profile.clientId,
                          //     'DSC Expiry': profile.dscExpDate,
                          //     'Digital Year': profile.digitalYear,
                          //     if (profile.remark != null)
                          //       'Remark': profile.remark,
                          //   },
                          // ),
                        ],
                      ),
                    ),

                    // Registrations Tab
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        _buildCompactInfoCard(
                          title: 'Trade License',
                          icon: Icons.card_membership,
                          items: {
                            'File Name': 'TradeLicense2024.pdf',
                            'Document No.': 'TL/2024/123456',
                            'Process Date': '01/01/2024',
                            'Expiry Date': '31/12/2024',
                            'Class': 'Class A',
                            'Status': 'Active',
                            'Year': '2024',
                            'File': 'View Document',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'MSME Registration',
                          icon: Icons.business_center,
                          items: {
                            'File Name': 'MSME_Cert_2024.pdf',
                            'Document No.': 'MSME/2024/789012',
                            'Process Date': '15/01/2024',
                            'Expiry Date': '14/01/2025',
                            'Class': 'Medium Enterprise',
                            'Status': 'Verified',
                            'Year': '2024',
                            'File': 'View Document',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'ISO Certification',
                          icon: Icons.verified,
                          items: {
                            'File Name': 'ISO_9001_2024.pdf',
                            'Document No.': 'ISO/9001/345678',
                            'Process Date': '01/03/2024',
                            'Expiry Date': '28/02/2025',
                            'Class': 'Quality Management',
                            'Status': 'Active',
                            'Year': '2024',
                            'File': 'View Document',
                          },
                        ),
                      ],
                    ),

                    // Portal IDs Tab
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        _buildCompactInfoCard(
                          title: 'Portal Credentials',
                          icon: Icons.web,
                          items: {
                            'GeM Portal': 'GEM123456789',
                            'CPPP Portal': 'CPPP/2024/98765',
                            'e-Procurement': 'ePRO/456789',
                            'Railway Portal': 'RLY/2024/34567',
                            'State Portal': 'STATE/MH/12345',
                          },
                        ),
                      ],
                    ),

                    // Net Banking Tab
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        _buildCompactInfoCard(
                          title: 'Net Banking Credentials',
                          icon: Icons.account_balance,
                          items: {
                            'Bank': 'State Bank of India',
                            'Net Banking ID': 'SBIN0123456',
                            'Remark': 'Primary Account for Tenders',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Net Banking Credentials',
                          icon: Icons.account_balance,
                          items: {
                            'Bank': 'HDFC Bank',
                            'Net Banking ID': 'HDFC789012',
                            'Remark': 'Secondary Account',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Net Banking Credentials',
                          icon: Icons.account_balance,
                          items: {
                            'Bank': 'ICICI Bank',
                            'Net Banking ID': 'ICIC345678',
                            'Remark': 'EMD Account',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Net Banking Credentials',
                          icon: Icons.account_balance,
                          items: {
                            'Bank': 'Bank of Baroda',
                            'Net Banking ID': 'BOB123456',
                            'Remark': 'Processing Fee Account',
                          },
                        ),
                      ],
                    ),

                    // Important Documents Tab
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        _buildCompactInfoCard(
                          title: 'Company Documents',
                          icon: Icons.description,
                          items: {
                            'File Name': 'Company_Registration.pdf',
                            'Document No.': 'CR/2024/123456',
                            'Issue Date': '01/01/2024',
                            'Valid Till': '31/12/2024',
                            'Status': 'Active',
                            'File': 'View Document',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Tax Documents',
                          icon: Icons.receipt_long,
                          items: {
                            'File Name': 'GST_Certificate.pdf',
                            'Document No.': 'GST/2024/789012',
                            'Issue Date': '01/04/2024',
                            'Valid Till': 'Lifetime',
                            'Status': 'Active',
                            'File': 'View Document',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Legal Documents',
                          icon: Icons.gavel,
                          items: {
                            'File Name': 'Partnership_Deed.pdf',
                            'Document No.': 'PD/2024/345678',
                            'Issue Date': '15/03/2024',
                            'Valid Till': 'Lifetime',
                            'Status': 'Active',
                            'File': 'View Document',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Bank Documents',
                          icon: Icons.account_balance,
                          items: {
                            'File Name': 'Bank_Statement.pdf',
                            'Document No.': 'BS/2024/901234',
                            'Issue Date': '01/04/2024',
                            'Valid Till': '30/04/2024',
                            'Status': 'Active',
                            'File': 'View Document',
                          },
                        ),
                      ],
                    ),

                    // Digital Signature Tab
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        _buildCompactInfoCard(
                          title: 'Digital Signature Details',
                          icon: Icons.verified_user,
                          items: {
                            'Start Date': '01/04/2024',
                            'Expired Date': '31/03/2025',
                            'Firm Name': 'Tech Solutions Pvt Ltd',
                            'Purpose': 'E-Tendering & GST Filing',
                            'Price': '₹2,500',
                            'Payment': 'Online - Net Banking',
                            'Payment Proof': 'View Receipt',
                            'Refer By': 'John Smith',
                            'Other Document Name': 'Authorization Letter',
                            'Other Document': 'View Document',
                            'Alternate Number': '+91 9876543210',
                            'Description':
                                'Class 3 DSC for tender participation and statutory compliance',
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildCompactInfoCard(
                          title: 'Previous DSC Records',
                          icon: Icons.history,
                          items: {
                            'Start Date': '01/04/2023',
                            'Expired Date': '31/03/2024',
                            'Firm Name': 'Tech Solutions Pvt Ltd',
                            'Purpose': 'E-Tendering',
                            'Price': '₹2,000',
                            'Payment': 'Online - UPI',
                            'Payment Proof': 'View Receipt',
                            'Refer By': 'Robert Johnson',
                            'Other Document Name': 'Company PAN',
                            'Other Document': 'View Document',
                            'Alternate Number': '+91 9876543211',
                            'Description':
                                'Class 2 DSC for basic tender participation',
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCompactInfoCard({
    required String title,
    required IconData icon,
    required Map<String, String?> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: lightRed,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: primaryRed, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...items.entries
                .map((entry) {
                  if (entry.value == null || entry.value!.isEmpty)
                    return const SizedBox();
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (entry.key != items.keys.last)
                        const Divider(
                            height: 16, thickness: 0.5), // Thinner divider
                    ],
                  );
                })
                .whereType<Widget>()
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTab(IconData icon, String label) {
    return Tab(
      height: 36, // Reduced from 40
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12), // Reduced from 16
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16, // Reduced from 18
            ),
            const SizedBox(width: 4), // Reduced from 8
            Text(
              label,
              style: const TextStyle(
                height: 1.2,
                fontWeight: FontWeight.w600,
                fontSize: 12, // Added smaller font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
