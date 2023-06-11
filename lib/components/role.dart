import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:home_tutor_app/components/StudentSignUpForm.dart';
import 'package:home_tutor_app/components/sign_up_form.dart';

// import 'package:home_tutor_app/screens/student.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  bool isstudent = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(100, 30, 20, 20),
          height: 200,
          width: 200,
          child: InkWell(
            child: const CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, bottom: 0, right: 0, top: 150),
                child: Text(
                  "Student",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              radius: 40.0,
              backgroundImage: AssetImage('assets/student2.png'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('student_register');
            },
          ),
        ),

        //  onTap: () {
        //     Navigator.of(context).pushNamed('student_register');
        //   },
      ]),
      Row(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(100, 30, 20, 20),
          height: 200,
          width: 200,
          child: InkWell(
            child: const CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, bottom: 0, right: 0, top: 150),
                child: Text(
                  "Teacher",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              radius: 40.0,
              backgroundImage: AssetImage('assets/teacher.jpg'),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('teacher_register');
            },
          ),
        ),
      ]),
    ]);
  }
}
