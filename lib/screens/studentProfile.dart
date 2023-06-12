import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentProfile extends StatelessWidget {
  final Student student;

  const StudentProfile({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: student.imgUrl != null
                      ? NetworkImage(student.imgUrl!)
                      : null,
                  child: student.imgUrl == null ? Icon(Icons.person) : null,
                ),
                SizedBox(height: 16),
                Text(
                  '${student.firstName} ${student.lastName}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Grade: ${student.grade}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Address: ${student.address}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: ${student.email}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Phone: ${student.phone}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
