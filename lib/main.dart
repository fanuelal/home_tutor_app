import 'package:home_tutor_app/components/sign_up_form.dart';
import './main_layout.dart';
import './models/auth_model.dart';
import './screens/auth_page.dart';
import './screens/booking_page.dart';
import './screens/student_registration_page.dart';
import './screens/teachers_registration_page.dart';
import './screens/success_booked.dart';
import './utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/payment.dart';
import 'providers/request.dart';
import 'providers/studentProvider.dart';
import 'providers/teacherProvider.dart';
import 'screens/homeScreenStudent.dart';
import 'providers/auth.dart';
import 'screens/homeScreenTeacher.dart';
import 'screens/studentProfile.dart';
import 'screens/teacherProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    //define ThemeData here
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>(
          create: (context) => AuthModel(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<RequestProvider>(
          create: (context) => RequestProvider(),
        ),
        ChangeNotifierProvider<StudentProvider>(
          create: (context) => StudentProvider(),
        ),
        ChangeNotifierProvider<TeacherProvider>(
          create: (context) => TeacherProvider(),
        ),
        ChangeNotifierProvider<Payment>(
          create: (context) => Payment(),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Teacher App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //pre-define input decoration
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey.shade700,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthPage(),
          'mainStudent': (context) => HomeScreenStudent(),
          'mainTeacher': (context) => HomeScreenTeacher(),
          'studentProfile': (context) => StudentProfile(),
          'teacherProfile': (context) => TeacherProfile(),
          'booking_page': (context) => BookingPage(),
          'success_booking': (context) => const AppointmentBooked(),
          'student_register': (context) => const StudentRegistrationPage(),
          'teacher_register': (context) => const TeachersRegistrationPage(),
        },
      ),
    );
  }
}
