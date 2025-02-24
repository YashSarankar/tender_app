import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  late Future<UserProfile> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getUserProfile();
  }

  // Define color constants
  static const Color primaryRed = Color(0xFFD32F2F);
  static const Color lightRed = Color(0xFFFFEBEE);
  static const Color darkRed = Color(0xFFB71C1C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryRed,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: primaryRed,
                      backgroundImage: profile.clientImage != null
                          ? NetworkImage(profile.clientImage!)
                          : null,
                      child: profile.clientImage == null
                          ? const Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: darkRed,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        onPressed: () {
                          // TODO: Handle profile picture update
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  profile.clientName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.emailId,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      _buildInfoCard(
                        title: 'Personal Information',
                        icon: Icons.person,
                        children: [
                          _buildInfoRow('Phone', profile.phone),
                          _buildInfoRow('Location', '${profile.city}, ${profile.state}'),
                          _buildInfoRow('District', profile.district),
                          _buildInfoRow('Country', profile.country),
                          _buildInfoRow('DSC Expiry', profile.dscExpDate),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: 'Document Information',
                        icon: Icons.document_scanner,
                        children: [
                          _buildInfoRow('GST No', profile.gstNo),
                          _buildInfoRow('PAN Card', profile.panCard),
                          _buildInfoRow('Aadhar Card', profile.aadharCard),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () {
                    // Handle edit profile
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text('Edit Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
    IconData? icon,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: primaryRed, size: 24),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 