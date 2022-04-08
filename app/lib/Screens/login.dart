import 'package:app/Screens/timeslots.dart';
import 'package:app/models/timeslot_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user_data_provider.dart';
import 'package:provider/provider.dart';

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
  Color buttonColor = const Color(0xffFF4D6D);
  Color textColor = const Color(0xffFFF0F3);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Consumer<UserDataProvider>(
            builder: (context, value, child) => Column(
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
                          // in this function we check to see if the email the user is logging in with exists in our server
                          bool isEmailValid(String email) {
                            bool found = false;
                            value.users.forEach((user) {
                              if (user["email"] == email) found = true;
                            });
                            return found;
                          }

                          if (userEmail == null || userEmail.isEmpty) {
                            return "Error: email cannot be empty";
                          } else if (!isEmailValid(userEmail.toString())) {
                            return 'Error: email not found';
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
                          // in this function we check to see if the password the user is logging in with exists in our server and
                          // if the password matches the email associated with it
                          bool isPasswordValid(String password, String email) {
                            if (value.users
                                .where((element) =>
                                    element['email'] == email &&
                                    element['password'] == password)
                                .isEmpty) return false;

                            return true;
                          }

                          if (userPassword == null || userPassword.isEmpty) {
                            return "Error: password cannot be empty";
                          } else if (!isPasswordValid(
                              userPassword.toString(), userEmail.text)) {
                            return 'Error: incorrect password';
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
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                                // if password and email are correct we goto the next screen
                                if (correctEmail && correctPass) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TimeSlotScreen()),
                                      (route) => false);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
