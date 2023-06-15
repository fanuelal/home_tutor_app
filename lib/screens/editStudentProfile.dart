import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/studentProvider.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';

class EditStudentProfilePage extends StatefulWidget {
  final Student student;
  bool isEdit = false;
  EditStudentProfilePage({required this.student});

  @override
  _EditStudentProfilePageState createState() => _EditStudentProfilePageState();
}

class _EditStudentProfilePageState extends State<EditStudentProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _gradeController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        TextEditingController(text: widget.student.firstName);
    _lastNameController = TextEditingController(text: widget.student.lastName);
    _gradeController =
        TextEditingController(text: widget.student.grade.toString());
    _addressController = TextEditingController(text: widget.student.address);
    _emailController = TextEditingController(text: widget.student.email);
    _phoneController = TextEditingController(text: widget.student.phone);
  }

  void saveChanges() {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    String? id = widget.student.id;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String stringGrade = _gradeController.text;
    int grade = int.tryParse(stringGrade) ?? 0;
    String address = _addressController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    Student student = Student(
        id: id,
        firstName: firstName,
        lastName: lastName,
        grade: grade,
        address: address,
        email: email,
        phone: phone);
    studentProvider
        .updateStudent(student)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text('profile updated successfully'),
            )))
        .then((value) => Navigator.of(context).pop());

    // Show the bottom sheet after saving the changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _gradeController,
              decoration: InputDecoration(
                labelText: 'Grade',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveChanges,
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
