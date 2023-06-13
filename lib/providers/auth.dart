import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/student.dart';
import '../models/teacher.dart';

class Auth extends ChangeNotifier {
  String _token = '';
  late DateTime _expiryDate = DateTime.now();
  late String _userId = '';
  // Timer _autoTimer;
  String userEmail = "user@gmail.com";
  String userName = "user";
  String isOwner = "";
  bool isAdmin = false;
  bool isAgent = false;
  bool get isAuth {
    return token != '';
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate.isAfter(DateTime.now()) && _token != '') {
      return _token;
    }
    return '';
  }

  void usernameExtractor() async {
    final user = await userEmail.split("@");
    userName = user[0];
  }

  Future<void> teacherSignUp(Teacher teacher, String password, String userType,
      BuildContext context) async {
    await _authenticate(teacher.email, password, 'signUp', userType, context);
    String baseURL =
        'https://estudy-376aa-default-rtdb.firebaseio.com/teachers';
    final userDataUrl = Uri.parse("$baseURL/$_userId.json");
    final usedData =
        await http.put(userDataUrl, body: json.encode(teacher.toJson()));
    currentTeacher = teacher;
  }

  Future<void> studentSignUp(Student student, String password, String userType,
      BuildContext context) async {
    await _authenticate(student.email, password, 'signUp', userType, context);
    String baseURL =
        'https://estudy-376aa-default-rtdb.firebaseio.com/students';
    print(_userId);
    if (_userId == null) return;
    final userDataUrl = Uri.parse("$baseURL/$_userId.json");
    final usedData =
        await http.put(userDataUrl, body: json.encode(student.toJson()));
    currentStudent = student;
  }

  late Student currentStudent;
  late Teacher currentTeacher;

  Future<void> getCurrentUser(String userId, String userType) async {
    if (userType == 'Student') {
      String studentBaseUrl =
          'https://estudy-376aa-default-rtdb.firebaseio.com/students/$userId.json';
      final response = await http.get(Uri.parse(studentBaseUrl));
      final responseData = json.decode(response.body);
      if (json.decode(response.body) == null) return;
      currentStudent = Student.fromJson(responseData);
      currentStudent.id = userId;
    } else {
      String teacherBaseUrl =
          'https://estudy-376aa-default-rtdb.firebaseio.com/teachers/$userId.json';
      final response = await http.get(Uri.parse(teacherBaseUrl));
      final responseData = json.decode(response.body);
      currentTeacher = Teacher.fromJson(responseData);
      currentTeacher.id = userId;
    }
    notifyListeners();
  }

  Future<void> _authenticate(String email, String password, String segmentStr,
      String userType, BuildContext context) async {
    // print('$email, $password, $userType');
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$segmentStr?key=AIzaSyDA4ed21i8rSzRsBe18X1LF0lNpxfx-BsI');
    userEmail = email;
    usernameExtractor();
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null || responseData['localId'] == null) {
        print(responseData['error']['message'].toString());
        SnackBar snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(responseData['error']['message'].toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
        // throw responseData['error']['message'];
      }
      print(responseData);
      // userEmail = email;
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      if (segmentStr == 'signInWithPassword') {
        getCurrentUser(_userId, userType);
      }
      String baseURL = '';

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
    } catch (error) {
      print(error);
      // throw error;
    }
  }

  Future<void> userRole() async {
    print("role identifier class called");
    try {
      final roleUrl = Uri.parse(
          "https://arkgift-3867d-default-rtdb.firebaseio.com/users/$_userId.json?");
      final roleRes = await http.get(roleUrl);

      isAdmin = json.decode(roleRes.body)['isTeacher'] ?? false;
    } catch (error) {
      print(error);
    }
  }

  Future<void> signIn(String email, String password, String userType,
      BuildContext context) async {
    return _authenticate(
        email, password, 'signInWithPassword', userType, context);
  }

  Future<void> signUp(
      String email, String password, String userType, BuildContext ctx) async {
    return _authenticate(email, password, 'signUp', userType, ctx);
  }

  Future<void> Logout() async {
    _token = '';
    _expiryDate = DateTime.now();
    _userId = '';
    isAdmin = false;
    isAgent = false;
    isOwner = '';

    notifyListeners();
  }
}
