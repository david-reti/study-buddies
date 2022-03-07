import 'package:app/Screens/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Color backgroundColor = const Color(0xffFFF0F3);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      home: HomePage(),
    );
  }
}
