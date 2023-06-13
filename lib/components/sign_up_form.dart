import 'package:home_tutor_app/components/button.dart';
import 'package:home_tutor_app/main.dart';
import 'package:home_tutor_app/models/auth_model.dart';
import 'package:home_tutor_app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../models/teacher.dart';
import '../providers/auth.dart';
import '../utils/config.dart';

class StudentSignUpForm extends StatefulWidget {
  StudentSignUpForm({Key? key}) : super(key: key);

  @override
  State<StudentSignUpForm> createState() => _StudentSignUpFormState();
}

class _StudentSignUpFormState extends State<StudentSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _addController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gradeController = TextEditingController();

  // firstName: _nameController.text,
  //                 lastName: _lnameController.text,
  //                 grade: int.parse(_gradeController.text),
  //                 address: _addController.text,
  //                 email: _emailController.text,
  //                 phone: _phoneController.text,
  bool obsecurePass = true;
  bool isLoagging = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SizedBox(
        height: size.height * 0.6,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Firstname',
                    labelText: 'Firstname',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: _lnameController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Lastname',
                    labelText: 'Lastname',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person_outlined),
                    prefixIconColor: Config.primaryColor,
                  ),
                ),
                Config.spaceSmall,
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
                TextFormField(
                  controller: _addController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Adress',
                    labelText: 'Adress',
                    alignLabelWithHint: true,
                  ),
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: _gradeController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Grade',
                    labelText: 'Grade',
                    alignLabelWithHint: true,
                  ),
                ),
                Config.spaceSmall,
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.text,
                  cursorColor: Config.primaryColor,
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    labelText: 'Phone number',
                    alignLabelWithHint: true,
                  ),
                ),
                Config.spaceSmall,
                Consumer<Auth>(
                  builder: (context, auth, child) {
                    return Button(
                      width: double.infinity,
                      title: 'Sign Up',
                      onPressed: () async {
                        Student student = Student(
                          firstName: _nameController.text,
                          lastName: _lnameController.text,
                          grade: int.parse(_gradeController.text),
                          address: _addController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                        );
                        setState(() {
                          isLoagging = true;
                        });
                        await auth.studentSignUp(
                            student, _passController.text, 'Student', context);
                        setState(() {
                          isLoagging = false;
                        });
                        if (auth.token != '') {
                          MyApp.navigatorKey.currentState!
                              .pushNamed('mainStudent');
                        }
                      },
                      disable: false,
                    );
                  },
                ),
                isLoagging
                    ? const CircularProgressIndicator()
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TeacherSignUpForm extends StatefulWidget {
  TeacherSignUpForm({Key? key}) : super(key: key);

  @override
  State<TeacherSignUpForm> createState() => _TeacherSignUpFormState();
}

class _TeacherSignUpFormState extends State<TeacherSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _addController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _expController = TextEditingController();
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();
  final _subjectController = TextEditingController();
  bool obsecurePass = true;
  bool isLogging = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Firstname',
              labelText: 'Firstname',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _lnameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Lastname',
              labelText: 'Lastname',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
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
          TextFormField(
            controller: _addController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
                hintText: 'Adress',
                labelText: 'Adress',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.location_searching)),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _expController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
                hintText: 'Experience',
                labelText: 'Experience',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.work_history)),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
                hintText: 'Phone number',
                labelText: 'Phone number',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.phone)),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _subjectController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
                hintText: 'Subject',
                labelText: 'Subject',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.book)),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
                hintText: 'Price per month',
                labelText: 'Price',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.attach_money_rounded)),
          ),
          Config.spaceSmall,
          Consumer<Auth>(
            builder: (context, auth, child) {
              return Button(
                width: double.infinity,
                title: 'Sign Up',
                onPressed: () async {
                  Teacher teacher = Teacher(
                    firstName: _nameController.text,
                    lastName: _lnameController.text,
                    experience: int.parse(_expController.text),
                    price: double.parse(_priceController.text),
                    address: _addController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    subject: _subjectController.text,
                  );
                  setState(() {
                    isLogging = true;
                  });
                  await auth.teacherSignUp(
                      teacher, _passController.text, 'Teacher', context);
                  setState((){
                  isLogging = false;
                  });
                  if (auth.token != '') {
                    MyApp.navigatorKey.currentState!.pushNamed('mainTeacher');
                  }
                },
                disable: false,
              );
            },
          ),
          isLogging
              ? const CircularProgressIndicator()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
