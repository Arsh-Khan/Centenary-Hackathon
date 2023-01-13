import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_practice/pages/contact.dart';
import 'package:my_practice/pages/forgot_password.dart';
import 'package:my_practice/pages/homepage.dart';
import 'package:my_practice/pages/login_page.dart';
import 'package:my_practice/pages/my_profile.dart';
import 'package:my_practice/pages/registration.dart';
import 'package:my_practice/pages/self_check_in.dart';
import 'package:my_practice/pages/self_check_out.dart';
import 'package:my_practice/pages/stash.dart';
import 'package:my_practice/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: GoogleFonts.lato().fontFamily,
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Stash(),
        MyRoutes.homeRoute: (context) => dashBoard(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.forgotpassRoute: (context) => Forgotpass(),
        MyRoutes.stashRoute: (context) => Stash(),
        MyRoutes.registrationRoute: (context) => Registration(),
        MyRoutes.qr_scanner_in: (context) => My_customized_widget_in(),
        MyRoutes.qr_scanner_out: (context) => My_customized_widget_out(),
        MyRoutes.contact_us: (context) => contact(),
        MyRoutes.my_profile: (context) => ProfilePage()
      },
    );
  }
}
