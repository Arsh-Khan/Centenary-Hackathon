// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_practice/services/auth/auth_exceptions.dart';
import 'package:my_practice/services/auth/auth_service.dart';
import 'package:my_practice/utils/check_vjti_email.dart';
import 'package:my_practice/utils/constants.dart';
import 'package:my_practice/utils/show_error_dialog.dart';
import '../utils/routes.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 186, 217, 194),
        child: Column(
          children: [
            SizedBox(height: 35),
            // Image.asset(
            //   "assets/images/welcome.png",
            //   fit: BoxFit.contain,
            //   color: Color.fromARGB(255, 186, 217, 194),
            //   colorBlendMode: BlendMode.colorBurn,
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            ),
            Text("Welcome To Online Library",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        hintText: "Enter your Fullname",
                        fillColor: Colors.white70),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        hintText: "Enter your Email Id",
                        fillColor: Colors.white70),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        hintText: "Enter password",
                        fillColor: Colors.white70),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        hintText: "Confirm password",
                        fillColor: Colors.white70),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      final name = _name.text;
                      try {
                        final isVJTIEmailID = emailCheck(email);
                        if (isVJTIEmailID) {
                          await AuthService.firebase()
                              .createUser(email: email, password: password);
                          final user = AuthService.firebase().currentUser;

                          if (user?.isEmailVerified ?? false) {
                            // devtools.log(userCredential.toString());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MyRoutes.stashRoute, (route) => false);
                          } else {
                            await AuthService.firebase()
                                .sendEmailVerification();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MyRoutes.verifyEmailRoute, (route) => false);
                          }
                        } else {
                          showErrorDiaglog(context, 'Enter a Valid VJTI ID');
                        }
                      } on WeakPasswordAuthException {
                        await showErrorDiaglog(context, 'Weak Password');
                      } on EmailAlreadyInUseAuthException {
                        await showErrorDiaglog(
                            context, 'Email is already in use');
                      } on InvalidEmailAuthException {
                        await showErrorDiaglog(
                            context, 'This is an invalid email address');
                      } on GenericAuthExceptions {
                        await showErrorDiaglog(context, 'Failed to register');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 248, 165, 40),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        fixedSize: Size(200, 50)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  ElevatedButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 186, 217, 194),
                      elevation: 0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
