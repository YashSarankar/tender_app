import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('NOTIFICATIONS', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _dummyNotifications.length,
        itemBuilder: (context, index) {
          final notification = _dummyNotifications[index];
          return Card(
            elevation: 0,
            child: ListTile(
              leading: Icon(
                notification.icon,
                color: notification.color,
                size: 28,
              ),
              title: Text(notification.title),
              subtitle: Text(notification.message),
              trailing: Text(
                notification.timeAgo,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;
  final Color color;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.color,
  });
}

final List<NotificationItem> _dummyNotifications = [
  NotificationItem(
    title: 'Document Approved',
    message: 'Your recent document submission has been approved.',
    timeAgo: '2m ago',
    icon: Icons.check_circle,
    color: Colors.green,
  ),
  NotificationItem(
    title: 'Signature Required',
    message: 'New document waiting for your digital signature.',
    timeAgo: '1h ago',
    icon: Icons.edit_document,
    color: Colors.blue,
  ),
  NotificationItem(
    title: 'DSC Expiring Soon',
    message: 'Your Digital Signature Certificate will expire in 30 days.',
    timeAgo: '3h ago',
    icon: Icons.warning,
    color: Colors.orange,
  ),
  NotificationItem(
    title: 'Document Rejected',
    message: 'Please review and resubmit the document with corrections.',
    timeAgo: '5h ago',
    icon: Icons.error,
    color: Colors.red,
  ),
  NotificationItem(
    title: 'New Feature Available',
    message: 'Check out our new document tracking feature!',
    timeAgo: '1d ago',
    icon: Icons.new_releases,
    color: Colors.purple,
  ),
]; 