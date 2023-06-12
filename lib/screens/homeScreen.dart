import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            UserProfileWidget(),
            const SizedBox(width: 8),
            const Text('Choose Teacher'),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: teacherList.length,
        itemBuilder: (context, index) {
          final teacher = teacherList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(teacher.imgUrl ?? ''),
            ),
            title: Text('${teacher.firstName} ${teacher.lastName}'),
            subtitle: Text(teacher.subject),
            trailing: ElevatedButton.icon(
              onPressed: () {
                if (teacher.status == 'online') {
                  // Handle the request
                  print('Requesting...');
                } else {
                  // Teacher is not available
                  print('Teacher is not available');
                }
              },
              icon: Icon(Icons.send),
              label: Text('Request'),
            ),
          );
        },
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the following code with your own implementation
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CircleAvatar(
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
          ),
          SizedBox(height: 8),
          Text('John Doe'),
        ],
      ),
    );
  }
}

class Teacher {
  final int? id;
  final String firstName;
  final String lastName;
  final int experience;
  final String? availableTime;
  final String? imgUrl;
  final double rate;
  final String? description;
  final double price;
  final String subject;
  final String address;
  final String status;
  final String phone;
  final String email;
  final String? password;

  Teacher({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.experience,
    this.availableTime,
    this.imgUrl,
    this.rate = 0.0,
    this.description,
    required this.price,
    required this.subject,
    required this.address,
    this.status = 'online',
    required this.phone,
    this.password,
    required this.email,
  });
}

// Example teacher data
List<Teacher> teacherList = [
  Teacher(
    id: 1,
    firstName: 'John',
    lastName: 'Doe',
    experience: 5,
    imgUrl: 'teacher_profile_image_url',
    rate: 4.5,
    price: 20.0,
    subject: 'Mathematics',
    address: '123 Main St',
    phone: '123-456-7890',
    email: 'john.doe@example.com',
  ),
  Teacher(
    id: 2,
    firstName: 'Jane',
    lastName: 'Smith',
    experience: 3,
    imgUrl: 'teacher_profile_image_url',
    rate: 4.2,
    price: 18.0,
    subject: 'Science',
    address: '456 Elm St',
    phone: '987-654-3210',
    email: 'jane.smith@example.com',
    status: 'offline',
  ),
  // Add more teachers here
];
