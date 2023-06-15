import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/teacher.dart';
import '../providers/teacherProvider.dart';
import 'editTeacherProfile.dart';

class TeacherProfile extends StatelessWidget {
  // final Teacher teacher;

  // const TeacherProfile({required this.teacher});
  @override
  Widget build(BuildContext context) {
    Teacher currentStudent =
        Provider.of<Auth>(context, listen: false).currentTeacher;
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Profile'),
      ),
      body: Center(
        child: Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
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
                        'Experience: ${currentStudent.experience} years',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Subject: ${currentStudent.subject}',
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
                        'Phone: h${currentStudent.phone}',
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
                            builder: (context) => EditTeacherProfilePage(
                                  teacher: currentStudent,
                                )),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
