import 'package:flutter/material.dart';
import 'package:app/data/sampleusers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 150),
      child: Form(
        key: _key,
        child: Column(
          children: [
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
                if (!isEmailValid(userEmail.toString())) {
                  return 'Error email not found';
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                labelText: "Password",
              ),
              obscureText: !_pwdVisibility,
              validator: (userPassword) {
                if (!isPasswordValid(userPassword.toString(), userEmail.text)) {
                  return 'Incorrect password';
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
                      // functionality will be added here to navigate to the various screens once the users logged in
                      if (correctEmail && correctPass) {}
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
    for (int i = 0; i < sampleusers.length; i++) {
      if (sampleusers[i]["email"] == email) {
        return true;
      }
    }
    return false;
  }

  bool isPasswordValid(String password, String email) {
    for (int i = 0; i < sampleusers.length; i++) {
      if (sampleusers[i]["email"] == email &&
          sampleusers[i]["password"] == password) {
        return true;
      }
    }
    return false;
  }
}
