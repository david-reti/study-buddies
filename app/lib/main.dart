import 'package:app/Screens/courses.dart';
import 'package:app/Screens/homepage.dart';
import 'package:app/models/courses_provider.dart';
import 'package:app/models/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/models/timeslot_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Color backgroundColor = const Color(0xffFFF0F3);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => CoursesProvider()),
        ChangeNotifierProxyProvider<UserDataProvider, TimeslotProvider>(
          create: (context) => TimeslotProvider(context, null),
          update: (context, provider, prev) =>
              TimeslotProvider(context, provider),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
        home: HomePage(),
      ),
    );
  }
}
