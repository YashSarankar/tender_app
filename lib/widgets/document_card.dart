import 'package:flutter/material.dart';
import 'package:tender_app/models/document.dart';
import 'package:tender_app/theme/app_theme.dart';

class DocumentCard extends StatelessWidget {
  final Document document;

  const DocumentCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              document.icon,
              size: 32,
              color: AppTheme.primaryRed,
            ),
            const SizedBox(height: 16),
            Text(
              document.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              document.status,
              style: TextStyle(
                color: _getStatusColor(document.status),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (document.startDate != null && document.endDate != null) ...[
              const SizedBox(height: 8),
              Text(
                'Valid from: ${_formatDate(document.startDate!)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Valid until: ${_formatDate(document.endDate!)}',
                style: TextStyle(
                  fontSize: 12,
                  color: document.isExpired ? AppTheme.primaryRed : Colors.grey[600],
                  fontWeight: document.isExpired ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'verified':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'not uploaded':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
} 