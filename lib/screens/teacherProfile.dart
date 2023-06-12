import 'package:flutter/material.dart';
import '../models/teacher.dart';

class TeacherProfile extends StatelessWidget {
  final Teacher teacher;

  const TeacherProfile({required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Profile'),
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
                  backgroundImage: teacher.imgUrl != null
                      ? NetworkImage(teacher.imgUrl!)
                      : null,
                  child: teacher.imgUrl == null ? Icon(Icons.person) : null,
                ),
                SizedBox(height: 16),
                Text(
                  '${teacher.firstName} ${teacher.lastName}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Experience: ${teacher.experience} years',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Subject: ${teacher.subject}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Address: ${teacher.address}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: ${teacher.email}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Phone: ${teacher.phone}',
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
