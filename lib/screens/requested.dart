import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/config.dart';

class HomeScreenStudent extends StatefulWidget {
  @override
  _HomeScreenStudentState createState() => _HomeScreenStudentState();
}

class _HomeScreenStudentState extends State<HomeScreenStudent> {
  TextEditingController _searchController = TextEditingController();
  List<Teacher> _filteredTeachers = teacherList;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterTeachers);
  }

  void _filterTeachers() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredTeachers = teacherList.where((teacher) {
        return teacher.firstName.toLowerCase().contains(searchTerm) ||
            teacher.lastName.toLowerCase().contains(searchTerm) ||
            teacher.subject.toLowerCase().contains(searchTerm) ||
            teacher.address.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                'https://logowik.com/content/uploads/images/810_student.jpg'),
          ),
        ),
        title: Text('Choose Teacher'),
        actions: [
          Consumer<Auth>(
            builder: (context, auth, child) => TextButton.icon(
              onPressed: () {
                auth.Logout();
                MyApp.navigatorKey.currentState!.pushNamed('/');
              },
              icon: Icon(Icons.power_settings_new),
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.transparent, // Set the primary color to transparent
              ),
              label: Text('Logout'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, location, or subject',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTeachers.length,
              itemBuilder: (context, index) {
                final teacher = _filteredTeachers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      teacher.imgUrl ??
                          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    ),
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
                    label: Text('pending'),
                  ),
                );
              },
            ),
          ),
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
    imgUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
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
    imgUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
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
