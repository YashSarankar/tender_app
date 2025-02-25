import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Document {
  final int id;
  final String documentId;
  final String? documentNumber;
  final String documentClassId;
  final String documentStatusId;
  final String documentYearId;
  final String documentImage;
  final String clientId;
  final String ownerId;
  final String processDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? documentName;
  final String? remarks;
  final bool isVerified;

  Document({
    required this.id,
    required this.documentId,
    this.documentNumber,
    required this.documentClassId,
    required this.documentStatusId,
    required this.documentYearId,
    required this.documentImage,
    required this.clientId,
    required this.ownerId,
    required this.processDate,
    required this.createdAt,
    required this.updatedAt,
    this.documentName,
    this.remarks,
    this.isVerified = false,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      documentId: json['document_id'] ?? '',
      documentNumber: json['document_number'] ?? '',
      documentClassId: json['document_class_id'] ?? '',
      documentStatusId: json['document_status_id'] ?? '',
      documentYearId: json['document_year_id'] ?? '',
      documentImage: json['document_image'] ?? '',
      clientId: json['client_id'] ?? '',
      ownerId: json['owner_id'] ?? '',
      processDate: json['process_date'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      documentName: json['document_name'],
      remarks: json['remarks'],
      isVerified: json['is_verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document_id': documentId,
      'document_number': documentNumber,
      'document_class_id': documentClassId,
      'document_status_id': documentStatusId,
      'document_year_id': documentYearId,
      'document_image': documentImage,
      'client_id': clientId,
      'owner_id': ownerId,
      'process_date': processDate,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'document_name': documentName,
      'remarks': remarks,
      'is_verified': isVerified,
    };
  }

  IconData get icon {
    switch (documentId) {
      case '16': // PAN Card
        return Icons.credit_card;
      case '17': // Aadhar Card
        return Icons.badge;
      case '18': // GST Registration
        return Icons.business;
      case '19': // MSME
        return Icons.factory;
      case '21': // Food License
        return Icons.restaurant;
      case '22': // PWD Registration
        return Icons.engineering;
      case '23': // Seal & Sign
        return Icons.draw;
      case '71': // WRD Registration
        return Icons.water_drop;
      case '72': // PHED Registration
        return Icons.plumbing;
      case '73': // RSMSB Registration
      case '74': // RUDSICO Registration
      case '77': // DLB Registration
        return Icons.account_balance;
      case '75': // Cancel Cheque
        return Icons.payment;
      case '76': // Latter Head
        return Icons.description;
      case '80': // Partnership Deed
        return Icons.handshake;
      default:
        return Icons.file_present;
    }
  }

  String get status => isExpired ? 'Expired' : 'Active';

  Color get statusColor => isExpired ? Colors.red : Colors.green;

  bool get isActive => !isExpired;

  String get formattedProcessDate {
    try {
      final date = DateTime.parse(processDate);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String get formattedCreatedAt {
    return DateFormat('dd MMM yyyy, hh:mm a').format(createdAt);
  }

  bool get isExpired {
    try {
      // Parse the process date
      final processDateTime = DateTime.parse(processDate);
      
      // Add years from document_year_id to get expiry date
      final yearsToAdd = int.tryParse(documentYearId) ?? 0;
      final expiryDate = DateTime(
        processDateTime.year + yearsToAdd,
        processDateTime.month,
        processDateTime.day,
      );
      
      // Compare with current date
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      return today.isAfter(expiryDate);
    } catch (e) {
      return false;
    }
  }

  int get daysUntilExpiry {
    try {
      // Parse the process date
      final processDateTime = DateTime.parse(processDate);
      
      // Add years from document_year_id to get expiry date
      final yearsToAdd = int.tryParse(documentYearId) ?? 0;
      final expiryDate = DateTime(
        processDateTime.year + yearsToAdd,
        processDateTime.month,
        processDateTime.day,
      );
      
      // Compare with current date
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      return expiryDate.difference(today).inDays;
    } catch (e) {
      return 0;
    }
  }

  String get formattedExpiryDate {
    try {
      final processDateTime = DateTime.parse(processDate);
      final yearsToAdd = int.tryParse(documentYearId) ?? 0;
      final expiryDate = DateTime(
        processDateTime.year + yearsToAdd,
        processDateTime.month,
        processDateTime.day,
      );
      return DateFormat('dd MMM yyyy').format(expiryDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String get documentClass {
    switch (documentClassId) {
      case '1':
        return 'Identity Proof';
      case '2':
        return 'Business Registration';
      case '3':
        return 'Legal Document';
      case '4':
        return 'Financial Document';
      case '5':
        return 'Certification';
      default:
        return 'Other';
    }
  }
} 