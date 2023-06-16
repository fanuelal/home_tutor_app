import 'package:flutter/material.dart';
import '../models/student.dart';
import '../providers/studentProvider.dart';

class StudentDetail extends StatefulWidget {
  final String studentId;

  StudentDetail({required this.studentId});

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student Details'),
        ),
        body: FutureBuilder(
          future: StudentProvider.getStudent(widget.studentId),
          builder: (context, student) {
            if (student.hasData) {
              return Center(
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
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTnPpw27TlK0FlQkZItv1YnkwYhfcnKPc0kA&usqp=CAU'),
                        ),
                        SizedBox(height: 16),
                        SizedBox(height: 16),
                        Text(
                          '${student.data?.firstName} ${student.data?.lastName}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Grade: ${student.data?.grade}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        SizedBox(height: 8),
                        Text(
                          'Address: ${student.data?.address}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email: ${student.data?.email}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Phone: ${student.data?.phone}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
