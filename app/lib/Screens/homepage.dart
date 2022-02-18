import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:app/Screens/register.dart';

class homePage extends StatelessWidget {
  final Color buttonColor = const Color(0xffFF4D6D);
  final Color textColor = const Color(0xffFFF0F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
            Container(
              width: 300,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 10,
                  ),
                  onPressed: () {
                    // if the login screen is selected, that navigation will show
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Login", style: TextStyle(color: textColor))),
            ),
            Container(
              width: 300,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 10,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Register", style: TextStyle(color: textColor))),
            )
          ]),
    ));
  }
}
