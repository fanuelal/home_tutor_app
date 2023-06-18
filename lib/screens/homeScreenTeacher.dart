import 'package:flutter/material.dart';
import 'package:home_tutor_app/providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/teacher.dart';
import '../main.dart';
import '../models/request.dart';
import '../providers/request.dart';
import '../utils/config.dart';
import 'studentDetail.dart';

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

  // Teacher currentTeacher = Teacher();

  void fetch() async {
    setState(() {
      _isLoading = true;
    });
    _allRequest = await Provider.of<RequestProvider>(context, listen: false)
        .getAllRequests(context);
    String userId = Provider.of<Auth>(context, listen: false).userId;
    // await Provider.of<Auth>(context, listen: false).getCurrentUser(userId, 'Teacher');
    
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

  String formatTimeDifference(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inSeconds > 0) {
      return '${difference.inSeconds} second${difference.inSeconds > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
   Teacher currentTeacher = Provider.of<Auth>(context, listen: false).currentTeacher;
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
                backgroundImage: NetworkImage((currentTeacher.imgUrl == null ||
                        currentTeacher.imgUrl == "")
                    ? 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png':
                    currentTeacher.imgUrl!
                    ),
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
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StudentDetail(
                                        studentId: teacher.requestSender),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    teacher.studentImg != ''
                                        ? teacher.studentImg
                                        : 'https://logowik.com/content/uploads/images/810_student.jpg',
                                  ),
                                ),
                                title: Text('${teacher.studentName}'),
                                subtitle: Text(
                                    "${teacher.subject}  - ${formatTimeDifference(teacher.created_at)}"),
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
                                    icon: Icon(teacher.isAccepted
                                        ? Icons.check
                                        : Icons.question_mark),
                                    label: Text(teacher.isAccepted
                                        ? 'Accepted'
                                        : 'Accept'),
                                  ),
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
