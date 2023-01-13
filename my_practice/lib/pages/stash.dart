import 'package:flutter/material.dart';

import '../utils/routes.dart';

class Stash extends StatelessWidget {
  const Stash({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Center(
                    child: Image.asset(
                      "assets/vjti-mumbai.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Center(
                    child: Text(
                      "VJTI DIGITAL LIBRARY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Image.asset(
                //   "assets/images/fitness.png",
                //   fit: BoxFit.contain,
                //   color: Color.fromARGB(255, 65, 234, 107),
                //   colorBlendMode: BlendMode.darken,
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: ElevatedButton(
                    child: Text(
                      "Get Started                         >>",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 50, 248, 83),
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            )));
  }
}
