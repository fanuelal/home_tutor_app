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
    return _token != '';
  }

  late Student currentStudent;
  late Teacher currentTeacher;
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
    await authenticate(teacher.email, password, 'signUp', userType, context);
    String baseURL =
        'https://estudy-376aa-default-rtdb.firebaseio.com/teachers';
    if (_userId != '') {
      final userDataUrl = Uri.parse("$baseURL/$_userId.json");
      final usedData =
          await http.put(userDataUrl, body: json.encode(teacher.toJson()));
      currentTeacher = teacher;
    }
  }

  Future<void> studentSignUp(Student student, String password, String userType,
      BuildContext context) async {
    await authenticate(student.email, password, 'signUp', userType, context);
    String baseURL =
        'https://estudy-376aa-default-rtdb.firebaseio.com/students';
    print(_userId);
    if (_userId == null) return;
    final userDataUrl = Uri.parse("$baseURL/$_userId.json");
    final usedData =
        await http.put(userDataUrl, body: json.encode(student.toJson()));
    currentStudent = student;
  }

  Future<void> getCurrentUser(
      String userId, String userType, BuildContext context) async {
    if (userType == 'Student') {
      String studentBaseUrl =
          'https://estudy-376aa-default-rtdb.firebaseio.com/students/$userId.json';
      print(studentBaseUrl);
      try {
        final response = await http.get(Uri.parse(studentBaseUrl));
        final responseData = json.decode(response.body);
        // if (json.decode(response.body) == null) return;

        currentStudent = Student.fromJson(responseData);
        currentStudent.id = userId;
      } catch (error) {
        print(error);
        SnackBar snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text("user Data not found or deleted!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      String teacherBaseUrl =
          'https://estudy-376aa-default-rtdb.firebaseio.com/teachers/$userId.json';
      print(teacherBaseUrl);
      try {
        final response = await http.get(Uri.parse(teacherBaseUrl));
        final responseData = json.decode(response.body);
        currentTeacher = Teacher.fromJson(responseData);
        currentTeacher.id = userId;
      } catch (error) {
       SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red,
          content: Text('User Data not found or deleted!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    notifyListeners();
  }

  Future<void> authenticate(String email, String password, String segmentStr,
      String userType, BuildContext context) async {
    print('$email, $password, $userType');
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$segmentStr?key=AIzaSyDA4ed21i8rSzRsBe18X1LF0lNpxfx-BsI');
    userEmail = email;
    // print('user email is ${userEmail}');
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
        // print(responseData['error']['message'].toString());
        SnackBar snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(responseData['error']['message'].toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      // print("where is error");
      // print(responseData['localId']);
      // userEmail = email;
      // print('responseData local id ${responseData['idToken']}');
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      if (segmentStr == 'signInWithPassword' || _token != '') {
        print('fetching your data');
        await getCurrentUser(_userId, userType, context);
        print('finished fetching your data');
      }
      String baseURL = '';

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      notifyListeners();
    } catch (error) {
      print(error.toString());
      // throw error;
    }
  }

  Future<void> signIn(String email, String password, String userType,
      BuildContext context) async {
    return await authenticate(
        email, password, 'signInWithPassword', userType, context);
  }

  Future<void> signUp(
      String email, String password, String userType, BuildContext ctx) async {
    return authenticate(email, password, 'signUp', userType, ctx);
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
