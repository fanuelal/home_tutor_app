import 'package:home_tutor_app/components/login_form.dart';
import 'package:home_tutor_app/components/sign_up_form.dart';
import 'package:home_tutor_app/utils/text.dart';
import 'package:flutter/material.dart';

import '../utils/config.dart';

class TeachersRegistrationPage extends StatefulWidget {
  const TeachersRegistrationPage({Key? key}) : super(key: key);

  @override
  State<TeachersRegistrationPage> createState() => _TeachersRegistrationPageState();
}

class _TeachersRegistrationPageState extends State<TeachersRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            // Text(
              
            //        AppText.enText['register_text']!,
            //   style: const TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Config.spaceSmall,
            TeacherSignUpForm(),
            Config.spaceSmall,
            const Spacer(),
            Config.spaceSmall,
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
    ));
  }
}
