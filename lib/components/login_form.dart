import 'dart:convert';

import 'package:home_tutor_app/components/button.dart';
import 'package:home_tutor_app/main.dart';
import 'package:home_tutor_app/models/auth_model.dart';
import 'package:home_tutor_app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/student.dart';
import '../models/teacher.dart';
import '../providers/auth.dart';
import '../utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  String? selectedUserType;
  bool isLogging = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black38,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
          ),
          Config.spaceSmall,
          Container(
            padding: EdgeInsets.only(left: 20),
            width: Config.screenWidth,
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              // color: Colors.black, // Background color
              border: Border.all(color: Colors.black), // Border color
              borderRadius: BorderRadius.circular(5), // Border radius
            ),
            child: DropdownButton<String>(
              value: selectedUserType,
              hint: const Text('Select user type',
                  style: TextStyle(color: Colors.grey)),
              items: ['Student', 'Teacher'].map((String userType) {
                return DropdownMenuItem<String>(
                  value: userType,
                  child: Text(userType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedUserType = newValue;
                });
              },
              dropdownColor: Colors.white, // Dropdown menu background color
              icon: const Icon(Icons.arrow_drop_down,
                  color: Colors.grey), // Dropdown icon color
              style: const TextStyle(color: Colors.grey), // Dropdown text color
              underline: Container(),
            ),
          ),
          Consumer<Auth>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign In',
                disable: false,
                onPressed: () async {
                  try {
                    if (selectedUserType == null) {
                      errorDialog(context, 'Please select a user type.');
                    } else {
                      setState(() {
                        isLogging = true;
                      });

                      await auth.signIn(
                          _emailController.text,
                          _passController.text,
                          selectedUserType ?? '',
                          context);
                      setState(() {
                        isLogging = false;
                      });
                      Student student;
                      Teacher teacher;
                      if (auth.token != '') {
                        selectedUserType == 'Student'
                            ? MyApp.navigatorKey.currentState!
                                .pushNamed('mainStudent')
                            : MyApp.navigatorKey.currentState!
                                .pushNamed('mainTeacher');
                      }
                    }

                    // final token = await DioProvider()
                    //     .getToken(_emailController.text, _passController.text);

                    // if (token != null) {
                    //   //grab user data here
                    //   final SharedPreferences prefs =
                    //       await SharedPreferences.getInstance();
                    //   final tokenValue = prefs.getString('token') ?? '';

                    // }
                  } catch (error) {
                    print('Error: $error');
                    // Handle errors here
                  }
                },
              );
            },
          ),
           isLogging ? CircularProgressIndicator(): SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<dynamic> errorDialog(BuildContext context, String error) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
