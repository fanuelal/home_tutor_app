import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/teacher.dart';

class TeacherProvider extends ChangeNotifier {
  static const String baseURL =
      'https://estudy-376aa-default-rtdb.firebaseio.com/teachers';
  List<Teacher> teachers = [];
  Teacher? currentTeacher;
  Future<List<Teacher>> getTeachers() async {
    final response = await http.get(Uri.parse('$baseURL.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<String> teacherId = jsonData.keys.toList();
      print(teacherId);
List<Teacher> _teachers = jsonData.entries.map((entry) {
  String id = entry.key;
  dynamic json = entry.value;
  return Teacher.fromJson({...json, 'id': id});
}).toList();
      teachers = _teachers;

      return _teachers;
    } else {
      throw Exception('Failed to fetch teachers');
    }
  }

  static Future<Teacher> getTeacher(String teacherId) async {
    final response = await http.get(
      Uri.parse('$baseURL/.json'),
      headers: {'Content-Type': 'application/json'},
    );
    final responseData = json.decode(response.body);
    Teacher teacher = Teacher.fromJson(responseData);
    if (response.statusCode != 200) {
      return teacher;
    } else {
      throw Exception('Failed to retrieve teacher');
    }
    // return null;
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
