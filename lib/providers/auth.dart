import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Auth extends ChangeNotifier{
  String _token = '';
  late DateTime _expiryDate;
  String _userId = '';
  // Timer _autoTimer;
  String userEmail = "user@gmail.com";
  String userName = "user";
  String isOwner = "";
  bool isAdmin = false;
  bool isAgent = false;
  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return '';
  }

  void usernameExtractor() async {
    final user = await userEmail.split("@");
    userName = user[0];
  }

  Future<void> _authenticate(
      String email, String password, String segmentStr) async {
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
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      // userEmail = email;
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      if (segmentStr == 'signUp') {
        final roleUrl = Uri.parse(
            "https://arkgift-3867d-default-rtdb.firebaseio.com/users/$_userId.json?auth=$_token");
        final usedData = http.put(roleUrl,
            body: json
                .encode({'email': email, 'isAdmin': false, 'isAgent': false}));
      }
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
      throw error;
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

    Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');

  }

  Future<void> Logout() async {
    _token = '';
    // _expiryDate = '';
    _userId = '';
    isAdmin = false;
    isAgent = false;
    isOwner = '';

    notifyListeners();
  }

}