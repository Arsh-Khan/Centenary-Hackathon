import 'package:flutter/material.dart';
import 'package:my_practice/database/display.dart';
import 'package:my_practice/utils/routes.dart';

import '../utils/routes.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({super.key});

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[50],
      appBar: AppBar(
          backgroundColor: Colors.deepOrange[50],
          elevation: 0,
          centerTitle: true,
          title: Text(
            "VJTI",
            style: TextStyle(
              fontSize: 50,
              letterSpacing: 7,
              color: Color.fromARGB(255, 124, 5, 5),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 5),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color.fromARGB(255, 127, 224, 204),
              ),
              height: 200,
              width: 371,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Text(
                        'Welcome\nRushi',
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.my_profile);
                      },
                    ),
                  ),
                  Image.asset(
                    'assets/pic.png',
                    height: 150,
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SENIORS' ADVICE
                Material(
                  color: Colors.deepOrange[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      //
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              'assets/books.jpeg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Books in the Library',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 70),
                Material(
                  color: Colors.deepOrange[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MyRoutes.displayDatabase, (route) => false);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              'assets/issue.jpeg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Books issued by you',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // NOTES & PYQS
                Material(
                  color: Colors.deepOrange[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.qr_scanner_in);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              'assets/check_in.jpeg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Self check-in',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 70),
                // ABOUT VJTI
                Material(
                  color: Colors.deepOrange[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.qr_scanner_out);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              'assets/checkout.jpeg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Self Checkout',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GALLERY
                Material(
                  color: Colors.deepOrange[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      //
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              'assets/deadlines.png',
                              height: 100,
                              width: 100,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Deadlines and fines',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 70),
                Material(
                  color: Colors.deepOrange[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.pushNamed(context, MyRoutes.contact_us);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              'assets/contact.png',
                              height: 100,
                              width: 100,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
