import 'package:flutter/material.dart';
import 'package:my_practice/services/auth/auth_exceptions.dart';
import 'package:my_practice/services/auth/auth_service.dart';
import 'package:my_practice/utils/check_vjti_email.dart';
import 'package:my_practice/utils/show_error_dialog.dart';
import '../utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });

      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 186, 217, 194),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                // Image.asset(
                //   "assets/images/login1_image.png",
                //   fit: BoxFit.contain,
                //   color: Color.fromARGB(255, 186, 217, 194),
                //   colorBlendMode: BlendMode.colorBurn,
                // ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text(
                    "Welcome $name!!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: "Enter Username",
                          labelText: "Username",
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: ((value) {
                          name = value;
                          setState(() {});
                        }),
                      ),
                      TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            } else if (value.length < 6) {
                              return "Password should be more than 6 characters";
                            }
                            return null;
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 215),
                  child: ElevatedButton(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.forgotpassRoute);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color.fromARGB(255, 186, 217, 194),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  color: Color.fromARGB(255, 249, 172, 58),
                  borderRadius: BorderRadius.circular(changebutton ? 50 : 25),
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        // if (email.isEmpty || password.isEmpty) {
                        //   showErrorDiaglog(context,
                        //       'Email or Password field cannot be empty');
                        // }
                        final isVJTIEmailID = emailCheck(email);

                        // devtools.log(isVJTIEmailID.toString());
                        // devtools.log('$email + $password');
                        if (isVJTIEmailID) {
                          await AuthService.firebase()
                              .logIn(email: email, password: password);
                          final user = AuthService.firebase().currentUser;
                          if (user?.isEmailVerified ?? false) {
                            // devtools.log(userCredential.toString());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MyRoutes.homeRoute, (route) => false);
                          } else {
                            await AuthService.firebase()
                                .sendEmailVerification();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MyRoutes.verifyEmailRoute, (route) => false);
                          }
                        } else {
                          showErrorDiaglog(context, 'Enter a Valid VJTI ID');
                        }
                      } on UserNotFoundAuthException {
                        await showErrorDiaglog(
                          context,
                          'User not Found',
                        );
                      } on WrongPasswordAuthException {
                        await showErrorDiaglog(
                          context,
                          'Wrong Credentials',
                        );
                      } on GenericAuthExceptions {
                        await showErrorDiaglog(
                          context,
                          'Authentication Error',
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: changebutton ? 75 : 250,
                      height: 50,
                      alignment: Alignment.center,
                      child: changebutton
                          ? Icon(
                              Icons.done,
                              color: Colors.black,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),

                      //  shape: changebutton?BoxShape.circle: BoxShape.rectangle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                ElevatedButton(
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.registrationRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 186, 217, 194),
                    elevation: 0,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
