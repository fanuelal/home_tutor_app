import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/teacher.dart';

class TeacherProvider extends ChangeNotifier {
  static const String baseURL = 'https://estudy-376aa-default-rtdb.firebaseio.com/teachers';

  Future<List<Teacher>> getTeachers() async {
    final response = await http.get(Uri.parse('$baseURL.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Teacher> teachers =
          data.map((json) => Teacher.fromJson(json)).toList();
      return teachers;
    } else {
      throw Exception('Failed to fetch teachers');
    }
  }

  Future<void> addTeacher(Teacher teacher) async {
    final response = await http.post(
      Uri.parse('$baseURL.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(teacher.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add teacher');
    }
  }

  Future<void> updateTeacher(Teacher teacher) async {
    final response = await http.put(
      Uri.parse('$baseURL/${teacher.id}.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(teacher.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update teacher');
    }
  }

  Future<void> deleteTeacher(int id) async {
    final response = await http.delete(Uri.parse('$baseURL/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete teacher');
    } else if (response.statusCode == 200) print("Teacher has been deleted");
  }

  Future<void> updateRequestStatus(int requestId, String newStatus) async {
  final url = '$baseURL/request/$requestId.json';
  final response = await http.patch(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'status': newStatus}),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update request status');
  }
}

}
