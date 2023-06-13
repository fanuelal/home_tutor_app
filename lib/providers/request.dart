import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/request.dart';

class RequestProvider extends ChangeNotifier {
  static const String baseURL =
      'https://estudy-376aa-default-rtdb.firebaseio.com/';

  List<Request> currentUserRequests = [];

  Future<void> updateRequestStatus(String requestId, String newStatus) async {
    final url = '$baseURL/request/$requestId.json';
    final response = await http.patch(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': newStatus}),
    );
    int index = currentUserRequests.indexWhere((req) => req.id == requestId);
    currentUserRequests[index].status = newStatus;
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
    currentUserRequests.add(request);
    print(json.decode(response.body));
    // if (response.statusCode != 201) {
    //   throw Exception('Failed to create request');
    // }
  }

  List<Request> getCurrentRequests(List<Request> reqs, BuildContext ctx) {
    Auth auth = Auth();
    List<Request> currentUserReq = [];
    // Provider.of<Auth>(ctx, listen: false).userId;
    print(Provider.of<Auth>(ctx, listen: false).userId);
    if (auth.userId != null) {
      currentUserReq = reqs
          .where((req) =>
              req.requestReciver ==
              Provider.of<Auth>(ctx, listen: false).userId)
          .toList();
    }
    return currentUserReq;
  }

  Future<List<Request>> getAllRequests(BuildContext ctx) async {
    const url = '$baseURL/request.json';
    final response = await http.get(Uri.parse(url));

    if (jsonDecode(response.body) == null) return [];
    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data != null) {
        List<Request> requests = data.entries
            .map((entry) => Request.fromJson(entry.value..['id'] = entry.key))
            .toList();
        List<Request> currentUserReq = getCurrentRequests(requests, ctx);
        currentUserRequests = currentUserReq;
        return currentUserReq;
      }
    }
    throw Exception('Failed to fetch requests');
  }

  List<Request> getCurrentStudentRequests(List<Request> reqs) {
    Auth auth = Auth();
    if (auth.userId != null || auth.userId != '') {
      List<Request> currentUserReq =
          reqs.where((req) => req.requestSender == auth.userId).toList();
      return currentUserReq;
    }
    print("auth.userId: ${auth.userId}");
    return [];
  }

  Future<List<Request>> getAllStudentRequests() async {
    const url = '$baseURL/request.json';
    final response = await http.get(Uri.parse(url));

    if (jsonDecode(response.body) == null) return [];
    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);
      print(data);
      if (data != null) {
        List<Request> requests = data.entries
            .map((entry) => Request.fromJson(entry.value..['id'] = entry.key))
            .toList();
        print(requests);
        List<Request> currentUserReq = getCurrentStudentRequests(requests);
        print(currentUserReq);
        currentUserRequests = currentUserReq;
        return currentUserReq;
      }
    }
    throw Exception('Failed to fetch requests');
  }
}
