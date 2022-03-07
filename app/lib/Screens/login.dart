import 'package:app/Screens/courses.dart';
import 'package:app/Screens/timeslots.dart';
import 'package:flutter/material.dart';
import 'package:app/data/sampleusers.dart';
import 'package:app/models/meeting_time.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 240, 243, 1),
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(255, 77, 109, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  bool _pwdVisibility = false;
  bool correctEmail = false;
  bool correctPass = false;
  List users = sampleusers;
  Color buttonColor = const Color(0xffFF4D6D);
  Color textColor = const Color(0xffFFF0F3);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: userEmail,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelText: "Email",
                          ),
                          validator: (userEmail) {
                            if (!isEmailValid(userEmail.toString())) {
                              return 'Error email not found';
                            } else {
                              correctEmail = true;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: userPassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _pwdVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _pwdVisibility = !_pwdVisibility;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelText: "Password",
                          ),
                          obscureText: !_pwdVisibility,
                          validator: (userPassword) {
                            if (!isPasswordValid(userPassword.toString())) {
                              return 'Incorrect password';
                            } else {
                              correctPass = true;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 10,
                              ),
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  // if password and email are correct we goto Courses screen
                                  if (correctEmail && correctPass) {
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return TimeSlotScreen(
                                            [MeetingTime(1, 2, "CIS*4030")]);
                                      },
                                    ), (route) => false);
                                  }
                                  _key.currentState!.save();
                                }
                              },
                              child: Text("Login",
                                  style: TextStyle(color: textColor))),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }

  // used to check if email is present in our dummy database (sampleusers.dart)
  bool isEmailValid(String email) {
    for (int i = 0; i < sampleusers.length; i++) {
      if (sampleusers[i]["email"] == email) {
        return true;
      }
    }
    return false;
  }

  // used to check if password is present in our dummy database (sampleusers.dart)
  bool isPasswordValid(String password) {
    for (int i = 0; i < sampleusers.length; i++) {
      if (sampleusers[i]["password"] == password) {
        return true;
      }
    }
    return false;
  }
}
