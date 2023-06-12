import 'package:home_tutor_app/components/login_form.dart';
import 'package:home_tutor_app/components/sign_up_form.dart';
import 'package:home_tutor_app/utils/text.dart';
import 'package:flutter/material.dart';

import '../components/role.dart';
import '../utils/config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    Config().init(context);
    return Scaffold(
      
      body:  SizedBox(
        height: Config.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              15,
              15,
              15,
              MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: Config.screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isSignIn
                        ? AppText.enText['welcome_text']!
                        : AppText.enText['choose-role']!,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spaceSmall,
                  Text(
                    isSignIn ? AppText.enText['signIn_text']! : "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spaceSmall,
                  isSignIn ? const LoginForm() : const ChooseRole(),
                  Config.spaceSmall,
                  isSignIn
                      ? Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              AppText.enText['forgot-password']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const Spacer(),
                  // Center(
                  // child: Text(
                  // AppText.enText['social-login']!,
                  // style: TextStyle(
                  // fontSize: 16,
                  // fontWeight: FontWeight.normal,
                  // color: Colors.grey.shade500,
                  // ),
                  // ),
                  // ),
                  Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        isSignIn
                            ? AppText.enText['signUp_text']!
                            : AppText.enText['registered_text']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSignIn = !isSignIn;
                          });
                        },
                        child: Text(
                          isSignIn ? 'Sign Up' : 'Sign In',
                          style: const TextStyle(
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
      ));
  }
}
