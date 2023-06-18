import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/teacherProvider.dart';
import 'package:provider/provider.dart';
import 'package:rate/rate.dart';
import '../models/teacher.dart';

class TeacherDetail extends StatelessWidget {
  final Teacher teacher;
  String? status = "accepted";
  TeacherDetail({required this.teacher, this.status});
  @override
  Widget build(BuildContext context) {
    // Teacher teacher =
    //   Provider.of<Auth>(context, listen: false).currentTeacher;
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
                  backgroundImage: NetworkImage(teacher.imgUrl ??
                      'https://cdn.vectorstock.com/i/preview-1x/50/63/logo-teacher-mascot-cartoon-style-vector-46355063.jpg'),
                ),
                SizedBox(height: 16),
                Rate(
                    iconSize: 40,
                    color: Colors.green,
                    allowHalf: true,
                    allowClear: true,
                    initialValue: teacher.rate,
                    readOnly: false,
                    onChange: (value) {
                      teacher.rate = value;
                      Provider.of<TeacherProvider>(context, listen: false)
                          .updateTeacher(teacher);
                    }),
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
                status == "accepted"
                    ? Text(
                        'Phone: ${teacher.phone}',
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
