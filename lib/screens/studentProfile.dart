import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:home_tutor_app/screens/editStudentProfile.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../providers/studentProvider.dart';

class StudentProfile extends StatelessWidget {
  // final Student? student;
  // const StudentProfile({required this.student});
  @override
  Widget build(BuildContext context) {
    Student currentStudent =
        Provider.of<Auth>(context, listen: false).currentStudent;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Profile'),
        ),
        body: Center(
            child: Card(
          elevation: 4,
          margin: EdgeInsets.all(16),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(100),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          NetworkImage(currentStudent.imgUrl ?? ''),
                      
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${currentStudent.firstName} ${currentStudent.lastName}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Grade: ${currentStudent.grade}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Address: ${currentStudent.address}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: ${currentStudent.email}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Phone: ${currentStudent.phone}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue, // Use the appropriate color here
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              EditStudentProfilePage(student: currentStudent)),
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
