// import 'dart:html';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/studentProvider.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../main.dart';
import '../models/student.dart';
import '../providers/auth.dart';
import '../utils/config.dart';

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
    bool isLogging = false;
  String profileUrl = "";
  String? filename;
  File? selectedFile;
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

  Future<String> uploadCertificate(file) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('profileImages/${DateTime.now()}/$filename');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    this.profileUrl = downloadUrl;
    print(downloadUrl);
    print("downloaded url id ${downloadUrl}");
    profileUrl = downloadUrl;
    return downloadUrl;
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
    String imageUrl = profileUrl;
    Student student = Student(
        id: id,
        firstName: firstName,
        lastName: lastName,
        grade: grade,
        address: address,
        email: email,
        phone: phone,
        imgUrl: imageUrl);
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
            SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    PlatformFile file = result!.files.first;
                    var file_size_bytes = file.size;
                    var file_size_mb = file_size_bytes / 1000000;
                    setState(() {
                      this.selectedFile = File(file.path!);
                      // this.size = file_size_mb;
                      this.filename = file.name;
                    });
                  },
                  icon: Icon(Icons.attach_file),
                  label: Text('Upload Profile Image'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    ),
                  ),
                ),
              ),
              filename != null
                  ? Text(filename!)
                  : Text("No certificate selected"),
              Config.spaceSmall,
              
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
