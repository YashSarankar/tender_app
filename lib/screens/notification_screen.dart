import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dummyNotifications.length,
        itemBuilder: (context, index) {
          final notification = dummyNotifications[index];
          return NotificationCard(notification: notification);
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(
          notification.icon,
          color: notification.isRead ? Colors.grey : Colors.blue,
        ),
        title: Text(notification.title),
        subtitle: Text(notification.message),
        trailing: Text(
          notification.timeAgo,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: () {
          // Handle notification tap
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
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    this.isRead = false,
  });
}

// Dummy data for testing
final List<NotificationItem> dummyNotifications = [
  NotificationItem(
    title: 'New Document Available',
    message: 'A new document has been shared with you',
    timeAgo: '2m ago',
    icon: Icons.description,
  ),
  NotificationItem(
    title: 'Reminder',
    message: 'Document review deadline approaching',
    timeAgo: '1h ago',
    icon: Icons.notification_important,
    isRead: true,
  ),
  NotificationItem(
    title: 'System Update',
    message: 'App successfully updated to latest version',
    timeAgo: '2h ago',
    icon: Icons.system_update,
    isRead: true,
  ),
  NotificationItem(
    title: 'Welcome!',
    message: 'Welcome to Tender App. Get started by exploring documents.',
    timeAgo: '1d ago',
    icon: Icons.waving_hand,
    isRead: true,
  ),
]; 