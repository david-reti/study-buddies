import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Register(),
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();
  bool _pwdVisibility = false;
  bool correctName = false;
  bool correctEmail = false;
  bool correctPass = false;
  HashMap userInfo = new HashMap<String, String>();
  Color buttonColor = const Color(0xffFF4D6D);
  Color textColor = const Color(0xffFFF0F3);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 150),
      child: Form(
        key: _key,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: userName,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                labelText: "Name",
              ),
              validator: (userName) {
                if (userName == null || userName.isEmpty) {
                  return 'Please enter your first and last name';
                } else if (!isNameValid(userName)) {
                  return 'Please enter a valid name containing only letters';
                } else {
                  correctName = true;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: userEmail,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                labelText: "Email",
              ),
              validator: (userEmail) {
                if (userEmail == null ||
                    userEmail.isEmpty ||
                    !isEmailValid(userEmail)) {
                  return 'Please enter a University of Guelph email';
                } else {
                  correctEmail = true;
                }
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: userPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _pwdVisibility ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _pwdVisibility = !_pwdVisibility;
                    });
                  },
                ),
                //           enabledBorder: new OutlineInputBorder(
                //   borderRadius: new BorderRadius.circular(25.0),
                //   borderSide:  BorderSide(color: Colors.pinkAccent ),

                // ),
                // focusedBorder: new OutlineInputBorder(
                //   borderRadius: new BorderRadius.circular(25.0),
                //   borderSide:  BorderSide(color: Colors.pinkAccent ),

                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                labelText: "Password",
              ),
              obscureText: !_pwdVisibility,
              validator: (userPassword) {
                if (userPassword == null || userPassword.isEmpty) {
                  return 'Please enter a password';
                } else {
                  correctPass = true;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 200,
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
                      if (correctName && correctEmail && correctPass) {
                        _displayTextInputDialog(context);
                    
                      }
                      _key.currentState!.save();
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    email = email.toLowerCase();
    return email.endsWith("@uoguelph.ca");
  }

  bool isNameValid(String name) {
    return RegExp(r'^[a-z]+$').hasMatch(name);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        );
          });
          return AlertDialog(
            title: Text(
                'A one-time password has been sent to ${userEmail.text}, please enter it here to comeplete verification'),
          );
        });
  }
}
