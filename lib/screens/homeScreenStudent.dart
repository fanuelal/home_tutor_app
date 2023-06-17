import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/request.dart';
import '../models/student.dart';
import '../models/teacher.dart';
import '../providers/payment.dart';
import '../providers/request.dart';
import '../providers/studentProvider.dart';
import '../providers/teacherProvider.dart';
import '../utils/config.dart';
import 'teacherDetail.dart';

class HomeScreenStudent extends StatefulWidget {
  @override
  _HomeScreenStudentState createState() => _HomeScreenStudentState();
}

class _HomeScreenStudentState extends State<HomeScreenStudent> {
  TextEditingController _searchController = TextEditingController();
  List<Teacher> _filteredTeachers = [];
  List<Teacher> _allTeachers = [];
  List<Request> _allMyRequest = [];

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    fetch();
    _searchController.addListener(_filterTeachers);
  }

  void check() {
    if (Provider.of<Auth>(context, listen: false).token == '') {
      // Provider.of<Auth>(context, listen: false).authenticate();
      Navigator.of(context).pushNamed('/');
    }
  }

  void fetch() async {
    setState(() {
      _isLoading = true;
    });
    _allTeachers = await Provider.of<TeacherProvider>(context, listen: false)
        .getTeachers();
    String userId = Provider.of<Auth>(context, listen: false).userId;
    print(userId);
    _allMyRequest = await Provider.of<RequestProvider>(context, listen: false)
        .getAllStudentRequests(userId);

    // final auth = Provider.of<Auth>(context, listen: false);
    // await Provider.of<Auth>(context, listen: false)
    //     .getCurrentUser(auth.userId, 'Student');
    Student cStud = Provider.of<Auth>(context, listen: false).currentStudent;
    filterByAddress(cStud);
    setState(() {
      _isLoading = false;
    });
    _filteredTeachers = _allTeachers;
  }

  void filterByAddress(Student stud) {
    _allTeachers = _allTeachers
        .where((teacher) =>
            teacher.address.toLowerCase().contains(stud.address.toLowerCase()))
        .toList();
  }

  Request? isRequested(Teacher teacher) {
    int index = -1;
    index = _allMyRequest.indexWhere((req) {
      print("requestReciver: ${req.requestReciver}");
      print('teacherId: ${teacher.id}');
      return req.requestReciver == teacher.id;
    });
    print("${index}");
    if (index > -1) {
      return _allMyRequest[index];
    } else {
      return null;
    }
  }

  void _filterTeachers() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredTeachers = _allTeachers.where((teacher) {
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
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                MyApp.navigatorKey.currentState!.pushNamed('studentProfile');
              },
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://logowik.com/content/uploads/images/810_student.jpg'),
              ),
            )),
        title: const Text('Choose Teacher'),
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
                  child: _filteredTeachers.isEmpty
                      ? const Center(child: Text('Opps No Teachers yet!'))
                      : ListView.builder(
                          itemCount: _filteredTeachers.length,
                          itemBuilder: (context, index) {
                            final teacher = _filteredTeachers[index];
                            Request? isReq = isRequested(teacher);

                            // bool isClicked = false;
                            if (isReq != null) {
                              teacher.requested = true;
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TeacherDetail(
                                      teacher: teacher,
                                      status: isReq == null ? "" : isReq.status,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  tileColor:
                                      teacher.requested ? Colors.green : null,
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      teacher.imgUrl ??
                                          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                    ),
                                  ),
                                  title: Text(
                                      '${teacher.firstName} ${teacher.lastName}'),
                                  subtitle: Text(
                                      "${teacher.subject} - ${teacher.address}"),
                                  trailing: Consumer<RequestProvider>(
                                      builder: (context, request, child) =>
                                          isReq != null &&
                                                  isReq.status == "accepted"
                                              ? (teacher.isPaid
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.call,
                                                        color: Colors
                                                            .black, // Set the icon color to green
                                                        size:
                                                            24, // Set the icon size if needed
                                                      ),
                                                      onPressed: () => {
                                                        callNumber(
                                                            teacher.phone)
                                                      },
                                                    )
                                                  : ElevatedButton.icon(
                                                      label: Text('pay'),
                                                      icon: Icon(
                                                        Icons.monetization_on,
                                                        color: Colors
                                                            .white, // Set the icon color to green
                                                        size:
                                                            24, // Set the icon size if needed
                                                      ),
                                                      onPressed: () {
                                                        Student cStud =
                                                            Provider.of<Auth>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentStudent;
                                                        teacher.isPaid = true;
                                                        Provider.of<TeacherProvider>(
                                                                context,
                                                                listen: false)
                                                            .updateTeacher(
                                                                teacher);

                                                        Provider.of<Payment>(
                                                                context,
                                                                listen: false)
                                                            .paymentFunc(
                                                                context,
                                                                cStud,
                                                                100);
                                                      },
                                                    ))
                                              : ElevatedButton.icon(
                                                  onPressed: () async {
                                                    Student cStud =
                                                        Provider.of<Auth>(
                                                                context,
                                                                listen: false)
                                                            .currentStudent;
                                                    Request _request = Request(
                                                      address: cStud.address,
                                                      requestSender:
                                                          cStud.id ?? '',
                                                      requestReciver:
                                                          teacher.id ?? '',
                                                      teacherName:
                                                          '${teacher.firstName} ${teacher.lastName}',
                                                      subject: teacher.subject,
                                                      teacherImg:
                                                          teacher.imgUrl ?? '',
                                                      studentImg:
                                                          cStud.imgUrl ?? '',
                                                      studentName:
                                                          '${cStud.firstName} ${cStud.lastName}',
                                                      grade: cStud.grade,
                                                      created_at:
                                                          DateTime.now(),
                                                      status: 'pending',
                                                    );
                                                    setState(() {
                                                      teacher.requested = true;
                                                    });
                                                    // print(t);
                                                    await request.createRequest(
                                                        _request, context);
                                                  },
                                                  icon: teacher.requested
                                                      ? const Icon(
                                                          Icons.timelapse)
                                                      : Icon(Icons.send),
                                                  label: isReq == null
                                                      ? Text(
                                                          isReq?.status ?? '')
                                                      : const Text('Request'),
                                                )),
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

  callNumber(phoneNumber) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
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

// class Teacher {
//   final String? id;
//   final String firstName;
//   final String lastName;
//   final int experience;
//   final String? availableTime;
//   final String? imgUrl;
//   final double rate;
//   final String? description;
//   final double price;
//   final String subject;
//   final String address;
//   final String status;
//   final String phone;
//   final String email;
//   final String? password;

//   Teacher({
//     this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.experience,
//     this.availableTime,
//     this.imgUrl,
//     this.rate = 0.0,
//     this.description,
//     required this.price,
//     required this.subject,
//     required this.address,
//     this.status = 'online',
//     required this.phone,
//     this.password,
//     required this.email,
//   });
// }

// Example teacher data
// List<Teacher> teacherList = [
//   Teacher(
//     id: '1',
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
//     id: '2',
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