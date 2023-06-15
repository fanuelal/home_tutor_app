import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/studentProvider.dart';
import 'package:home_tutor_app/providers/teacherProvider.dart';
import 'package:provider/provider.dart';

import '../models/teacher.dart';

class EditTeacherProfilePage extends StatefulWidget {
  late final Teacher teacher;
  bool isEdit = false;
  EditTeacherProfilePage({required this.teacher});

  @override
  _EditTeacherProfilePageState createState() => _EditTeacherProfilePageState();
}

class _EditTeacherProfilePageState extends State<EditTeacherProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _experienceController;
  late TextEditingController _subjectController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _firstNameController =
        TextEditingController(text: widget.teacher.firstName);
    _lastNameController = TextEditingController(text: widget.teacher.lastName);
    _experienceController =
        TextEditingController(text: widget.teacher.experience.toString());
    _subjectController = TextEditingController(text: widget.teacher.subject);
    _addressController = TextEditingController(text: widget.teacher.address);
    _emailController = TextEditingController(text: widget.teacher.email);
    _phoneController = TextEditingController(text: widget.teacher.phone);
  }

  void saveChanges() {
    final teacherProvider =
        Provider.of<TeacherProvider>(context, listen: false);
    String? id = widget.teacher.id;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String stringExperience = _experienceController.text;
    int experience = int.tryParse(stringExperience) ?? 0;
    String address = _addressController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    Teacher teacher = Teacher(
        id: id,
        firstName: firstName,
        lastName: lastName,
        experience: experience,
        address: address,
        email: email,
        phone: phone,
        price: widget.teacher.price,
        subject: widget.teacher.subject,
        certificate: widget.teacher.certificate);
    teacherProvider
        .updateTeacher(teacher)
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
              controller: _experienceController,
              decoration: InputDecoration(
                labelText: 'Experience',
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
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
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
