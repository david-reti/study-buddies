import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:app/Screens/register.dart';

class HomePage extends StatelessWidget {
  final Color buttonColor = const Color(0xffFF4D6D);
  final Color textColor = const Color(0xffFFF0F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Text("Study Buddies",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonColor,
                          fontSize: 30))),
              Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 10,
                          ),
                          onPressed: () {
                            // if login is presssed, we route to LoginScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Text("Login",
                              style: TextStyle(color: textColor)))),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 10,
                          ),
                          onPressed: () {
                            // if Register is presssed, we route to the Registration screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterScreen();
                                },
                              ),
                            );
                          },
                          child: Text("Register",
                              style: TextStyle(color: textColor)))),
                ],
              ),
            ]),
      ),
    ));
  }
}
