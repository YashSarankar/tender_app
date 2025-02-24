import 'package:flutter/material.dart';

class Document {
  final String title;
  final IconData icon;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;

  Document({
    required this.title,
    required this.icon,
    required this.status,
    this.startDate,
    this.endDate,
  });

  bool get isExpired {
    if (endDate == null) return false;
    return DateTime.now().isAfter(endDate!);
  }
} 