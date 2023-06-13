import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/request.dart';
import '../providers/request.dart';
import '../utils/config.dart';

class HomeScreenTeacher extends StatefulWidget {
  @override
  _HomeScreenStudentState createState() => _HomeScreenStudentState();
}

class _HomeScreenStudentState extends State<HomeScreenTeacher> {
  TextEditingController _searchController = TextEditingController();
  List<Request> _filteredRequests = [], _allRequest = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    fetch();
    _searchController.addListener(_filterTeachers);
  }

  void fetch() async {
    setState(() {
      _isLoading = true;
    });
    _allRequest = await Provider.of<RequestProvider>(context, listen: false)
        .getAllRequests(context);
    setState(() {
      _isLoading = false;
    });
    _filteredRequests = _allRequest;
  }

  void _filterTeachers() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredRequests = _allRequest.where((teacher) {
        return teacher.studentName.toLowerCase().contains(searchTerm) ||
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
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                MyApp.navigatorKey.currentState!.pushNamed('teacherProfile');
              },
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
              ),
            )),
        title: const Text('Choose Student'),
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
              decoration: const InputDecoration(
                hintText: 'Search by name, location, or subject',
              ),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: _filteredRequests.isEmpty
                      ? const Center(
                          child: Text('Opps no request!'),
                        )
                      : ListView.builder(
                          itemCount: _filteredRequests.length,
                          itemBuilder: (context, index) {
                            final teacher = _filteredRequests[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  teacher.studentImg != ''
                                      ? teacher.studentImg
                                      : 'https://logowik.com/content/uploads/images/810_student.jpg',
                                ),
                              ),
                              title: Text('${teacher.studentName}'),
                              subtitle: Text(teacher.subject),
                              trailing: Consumer<RequestProvider>(
                                builder: (ctx, req, child) =>
                                    ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (states) {
                                        if (teacher.isAccepted) {
                                          return Colors.green;
                                        } else {
                                          return Colors.blue;
                                        }
                                      },
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      teacher.isAccepted = true;
                                    });
                                    await req.updateRequestStatus(
                                        teacher.id ?? '', 'accepted');
                                  },
                                  icon:  Icon(teacher.isAccepted ? Icons.question_mark : Icons.check),
                                  label:  Text(teacher.isAccepted ? 'Accepted': 'Accept'),
                                ),
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

// class UserProfileWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace the following code with your own implementation
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [

//           SizedBox(height: 8),
//           Text('John Doe'),
//         ],
//       ),
//     );
//   }
// }

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
// List<Teacher> teacherList = [
//   Teacher(
//     id: 1,
//     firstName: 'John',
//     lastName: 'Doe',
//     experience: 5,
//     imgUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
//     rate: 4.5,
//     price: 20.0,
//     subject: 'Mathematics',
//     address: '123 Main St',
//     phone: '123-456-7890',
//     email: 'john.doe@example.com',
//   ),
//   Teacher(
//     id: 2,
//     firstName: 'Jane',
//     lastName: 'Smith',
//     experience: 3,
//     imgUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
//     rate: 4.2,
//     price: 18.0,
//     subject: 'Science',
//     address: '456 Elm St',
//     phone: '987-654-3210',
//     email: 'jane.smith@example.com',
//     status: 'offline',
//   ),
//   // Add more teachers here
// ];
