import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tender_app/theme/app_theme.dart';
import 'dart:convert';
import '../models/document.dart';
import '../widgets/document_card.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  List<Document> documents = [];
  List<Document> filteredDocuments = [];
  bool isLoading = true;
  String? error;
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  Map<String, String> documentNames = {};

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  void filterDocuments(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDocuments = List.from(documents);
      } else {
        filteredDocuments = documents.where((document) {
          final documentName = document.documentName?.toLowerCase() ?? '';
          return documentName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> fetchDocuments() async {

    //get userid from shared preferences
    final user = await SharedPreferences.getInstance();
    final userId = user.getString('user_id');
    try {
      final response = await http.get(
        Uri.parse('https://crm.actthost.com/api/get-document/$userId'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          // First, create a map of document IDs to names
          final docIds = (data['doc_ids'] as List).fold<Map<String, String>>(
            {},
            (map, doc) => map..putIfAbsent(doc['id'].toString(), () => doc['document_name']),
          );

          final List<dynamic> documentsList = data['documentDetails'];
          setState(() {
            documents = documentsList.map((doc) {
              final document = Document.fromJson(doc);
              return Document(
                id: document.id,
                documentId: document.documentId,
                documentNumber: document.documentNumber,
                documentClassId: document.documentClassId,
                documentStatusId: document.documentStatusId,
                documentYearId: document.documentYearId,
                documentImage: document.documentImage,
                clientId: document.clientId,
                ownerId: document.ownerId,
                processDate: document.processDate,
                createdAt: document.createdAt,
                updatedAt: document.updatedAt,
                documentName: docIds[document.documentId],
              );
            }).toList();
            filteredDocuments = List.from(documents);
            isLoading = false;
          });
        } else {
          setState(() {
            error = 'Failed to load documents';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          error = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: isSearching
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey[600]),
                            onPressed: () {
                              _searchController.clear();
                              filterDocuments('');
                            },
                          )
                        : null,
                    hintText: 'Search documents...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  onChanged: filterDocuments,
                ),
              )
            : Row(
                children: [
                  Icon(Icons.document_scanner_outlined, color: Colors.black),
                  SizedBox(width: 16),
                  Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  _searchController.clear();
                  filterDocuments('');
                }
              });
            },
            icon: Icon(
              isSearching ? Icons.arrow_back : Icons.search_outlined,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final document = filteredDocuments[index];
                    return DocumentCard(document: document);
                  },
                ),
    );
  }
} 