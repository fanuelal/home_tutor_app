import 'package:home_tutor_app/components/login_form.dart';
import 'package:home_tutor_app/components/sign_up_form.dart';
import 'package:home_tutor_app/utils/text.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class TeachersRegistrationPage extends StatefulWidget {
  const TeachersRegistrationPage({Key? key}) : super(key: key);
  @override
  State<TeachersRegistrationPage> createState() =>
      _TeachersRegistrationPageState();
}

class _TeachersRegistrationPageState extends State<TeachersRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Config().init(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                15, 15, 15, MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: size.height * 0.8,
              // width: size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppText.enText['as_teacher']!,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spaceSmall,
                  Flexible(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: size.height * 0.6,
                        child: SafeArea(child: TeacherSignUpForm()),
                      ),
                    ),
                  ),
                  Config.spaceSmall,
                  // const Spacer(),
                  // Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppText.enText['registered_text']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/');
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
