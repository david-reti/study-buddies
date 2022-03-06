import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
  // here a FormState global key is made to help with form validation
  final _key = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();
  bool _pwdVisibility = false;
  bool correctName = false;
  bool correctEmail = false;
  bool correctPass = false;
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
                      child:
                          // text field for the name of the user
                          TextFormField(
                        controller: userName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelText: "Name",
                        ),
                        // the validator is used to error check the users input field, if its correct we proceed otherwise we dont accept input
                        validator: (userName) {
                          if (userName == null || userName.isEmpty) {
                            return 'Please enter your first and last name';
                          } else if (!isNameValid(userName)) {
                            return 'Please enter a valid name containing only letters';
                          } else {
                            // if the users input was correct we come here
                            correctName = true;
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
                              // if the user wants to hide/show their password they'll toggle this icon
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
                          if (userPassword == null || userPassword.isEmpty) {
                            return 'Please enter a password';
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
                              // validating all of the forms' input here
                              if (_key.currentState!.validate()) {
                                if (correctName &&
                                    correctEmail &&
                                    correctPass) {
                                  // if all of the input is correct, we send them an alert dialog
                                  _displayTextInputDialog(context);
                                }
                                _key.currentState!.save();
                              }
                            },
                            child: Text("Register",
                                style: TextStyle(color: textColor))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  // the email needs to be a valid University of Guelph email
  bool isEmailValid(String email) {
    email = email.toLowerCase();
    return email.endsWith("@uoguelph.ca");
  }

  // their name needs to be only consisting of letters
  bool isNameValid(String name) {
    return RegExp(r'^[a-z]+$').hasMatch(name);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          /* we close the alert after 5 seconds and route to login since the backend functionality to send a verfication
           email does not exist yet */
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          });
          return AlertDialog(
            title: Text(
                'A one-time password has been sent to ${userEmail.text}, please enter it here to complete verification'),
          );
        });
  }
}
