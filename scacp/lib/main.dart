// import 'package:flutter/material.dart';
// import 'package:scacp/dbHelper/mongodb.dart';
// import 'package:scacp/insert.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await MongoDatabase.connect();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MongoDbInsert(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(child: Text('Hello')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:xplorevjtiofficialapp/constants/routes.dart';
import 'package:xplorevjtiofficialapp/views/about_vjti_view.dart';
import 'package:xplorevjtiofficialapp/views/dashboard_view.dart';
import 'package:xplorevjtiofficialapp/views/login_view_non_vjti.dart';
import 'package:xplorevjtiofficialapp/views/login_view_vjti.dart';
import 'package:xplorevjtiofficialapp/views/sign_up_non_vjti.dart';
import 'package:xplorevjtiofficialapp/views/sign_up_vjti.dart';
import 'package:xplorevjtiofficialapp/services/auth/auth_service.dart';
import 'package:xplorevjtiofficialapp/views/splash_screen.dart';
import 'dart:developer' as devtools show log;
import 'package:xplorevjtiofficialapp/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: {
      loginVJTIRoute: (context) => const LoginViewVJTI(),
      signUpVJTIRoute: (context) => const SignUpVJTI(),
      loginNonVJTIRoute: (context) => const LoginViewNonVJTI(),
      dashBoardRoute: (context) => const DashBoardView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      signUpNonVJTIRoute: (context) => const SignUpNonVJTI(),
      aboutVJTIRoute: (context) => const AboutVJTIView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      FutureBuilder Widget is used to create widgets based on the latest snapshot of interaction with a Future
      It also helps us  to execute some Asynchronous code and based upon that UI will update.
      It has four states.
    */
    return FutureBuilder(
        future: AuthService.firebase().initalize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              AuthService.firebase().logOut();
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  devtools.log('User is Verified');
                  return const DashBoardView();
                } else {
                  AuthService.firebase().sendEmailVerification();
                  return const VerifyEmailView();
                }
              } else {
                return const LoginViewVJTI();
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
