import 'package:app/Screens/courses.dart';
import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

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
  final TextEditingController verificationCode = TextEditingController();
  final randomCode = Random().nextInt(1000);
  var _jsonData = [];
  bool _pwdVisibility = false;
  bool correctName = false;
  bool correctEmail = false;
  bool correctPass = false;
  bool _correctCode = false;
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
                            return 'Error: name cannot be empty';
                          } else if (!isNameValid(userName)) {
                            return 'Error: only letters are acceptable in this field';
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
                          if (userEmail == null || userEmail.isEmpty) {
                            return "Error: email cannot be empty";
                          } else if (!isEmailValid(userEmail.toString())) {
                            return 'Error: email needs to be a valid University of Guelph email';
                          } else if (doesEmailExist(userEmail.toString())) {
                            return 'Error: email alreay exists';
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
                            return "Error: password cannot be empty";
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
                              // validating all of the forms' input here
                              if (_key.currentState!.validate()) {
                                if (correctName &&
                                    correctEmail &&
                                    correctPass) {
                                  postUserData();
                                  sendEmail();
                                  // if all of the input is correct, we send them an alert dialog
                                  verificationDialog(context);
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

  // here an api is used to send a custom-made email to the user containing their verfication code
  Future sendEmail() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': 'service_eabt87l',
        'template_id': 'template_49e7gj3',
        'user_id': 'MO28iMsokWQMd98T8',
        'template_params': {
          'user_name': userName.text,
          'user_email': userEmail.text,
          'user_message': randomCode
        }
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // in this function, we send a http post request and send the data inputted from the user back to the server
  void postUserData() async {
    final response = await http.post(Uri.parse('http://3.97.30.243:3002/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "name": userName.text,
          "email": userEmail.text,
          "password": userPassword.text,
        }));
  }

  // the email needs to be a valid University of Guelph email
  bool isEmailValid(String email) {
    email = email.toLowerCase();
    return email.endsWith("@uoguelph.ca");
  }

  // we verify if the email already exists on the server
  bool doesEmailExist(String email) {
    for (int i = 0; i < _jsonData.length; i++) {
      if (_jsonData[i]["email"] == email) {
        return true;
      }
    }
    return false;
  }

  // in this function, we send a http get request and retrieve the data from the server
  void getUserData() async {
    final response = await http.get(Uri.parse('http://3.97.30.243:3002/users'));

    final jsonData = jsonDecode(response.body) as List;

    setState(() {
      _jsonData = jsonData;
    });
  }

  // their name needs to be only consisting of letters
  bool isNameValid(String name) {
    return RegExp(r'^[a-z]+$').hasMatch(name);
  }

  Future<void> verificationDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                  'A one-time code has been sent to ${userEmail.text}, please enter it here to complete verification:'),
              content: TextField(
                controller: verificationCode,
                decoration: InputDecoration(
                  errorText: _correctCode ? "Invalid code" : null,
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Code",
                ),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 10,
                    ),
                    onPressed: () {
                      setState(() {
                        verificationCode.text.isEmpty ||
                                verificationCode.text != randomCode.toString()
                            ? _correctCode = true
                            : _correctCode = false;
                      });
                      // if the verification code entered by user is correct
                      if (!_correctCode) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Courses();
                            },
                          ),
                        );
                      }
                    },
                    child: Text("Submit", style: TextStyle(color: textColor))),
              ],
            );
          });
        });
  }
}
