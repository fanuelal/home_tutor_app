import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/student.dart';
// import '../models/teacher.dart';

class StudentProvider extends ChangeNotifier {
  static const String baseURL =
      'https://estudy-376aa-default-rtdb.firebaseio.com/students';
  List<Student> students = [];
  Student? currentStudent = null;
  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse('$baseURL.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Student> _teachers =
          data.map((json) => Student.fromJson(json)).toList();
      students = _teachers;
      return students;
    } else {
      throw Exception('Failed to fetch teachers');
    }
  }

  static Future<Student> getStudent(String studentId) async {
    final response = await http.get(
      Uri.parse('$baseURL/$studentId.json'),
      headers: {'Content-Type': 'application/json'},
    );
    final responseData = json.decode(response.body);
    Student student = Student.fromJson(responseData);
    if (response.statusCode == 200) {
      return student;
    } else {
      throw Exception('Failed to retrieve teacher');
    }
    // return null;
  }

  Future<void> addStudent(Student student) async {
    final response = await http.post(
      Uri.parse('$baseURL.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add teacher');
    }
  }

  Future<void> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse('$baseURL/${student.id}.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update teacher');
    }
  }

  Future<void> deleteStudent(int id) async {
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
