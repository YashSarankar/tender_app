import 'package:flutter/material.dart';
import 'package:tender_app/theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'NOTIFICATIONS',
          style: TextStyle(
            color: AppTheme.primaryRed,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.primaryRed),
        actions: [
          if (dummyNotifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.done_all),
              onPressed: () {
                // Handle mark all as read
              },
              tooltip: 'Mark all as read',
            ),
        ],
      ),
      body: dummyNotifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryRed.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 50,
                      color: AppTheme.primaryRed.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No Notifications Yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ll be notified about updates here',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Handle notification tap
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: notification.isRead 
                        ? Colors.grey[100] 
                        : AppTheme.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: notification.isRead
                        ? null
                        : Border.all(
                            color: AppTheme.primaryRed.withOpacity(0.2),
                            width: 1,
                          ),
                  ),
                  child: Icon(
                    notification.icon,
                    color: notification.isRead 
                        ? Colors.grey[600] 
                        : AppTheme.primaryRed,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                                color: notification.isRead
                                    ? Colors.grey[800]
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: notification.isRead
                                  ? Colors.grey[100]
                                  : AppTheme.primaryRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              notification.timeAgo,
                              style: TextStyle(
                                fontSize: 12,
                                color: notification.isRead
                                    ? Colors.grey[600]
                                    : AppTheme.primaryRed,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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