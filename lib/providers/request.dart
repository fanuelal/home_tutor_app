import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/request.dart';

class RequestProvider extends ChangeNotifier {
  static const String baseURL = 'https://estudy-376aa-default-rtdb.firebaseio.com/request';
  Future<void> updateRequestStatus(int requestId, String newStatus) async {
  final url = '$baseURL/$requestId.json';
  final response = await http.patch(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'status': newStatus}),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update request status');
  }
}


Future<void> createRequest(Request request) async {
  final url = '$baseURL/request.json';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(request.toJson()),
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to create request');
  }
}


Future<List<Request>> getAllRequests() async {
  final url = '$baseURL/request.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final Map<String, dynamic>? data = jsonDecode(response.body);
    if (data != null) {
      List<Request> requests = data.entries
          .map((entry) => Request.fromJson(entry.value..['id'] = entry.key))
          .toList();
      return requests;
    }
  }
  throw Exception('Failed to fetch requests');
}

}