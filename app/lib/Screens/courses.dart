import 'package:app/Screens/login.dart';
import 'package:app/Screens/scheduling.dart';
import 'package:app/models/courses_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/Screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final Color themeColor = const Color(0xffFF4D6D);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        title: "ListView.builder",
        color: Color.fromRGBO(255, 240, 243, 1.0),
        /*theme: new ThemeData(
            //primarySwatch: Colors.red
            primarySwatch: Colors.red),*/
        debugShowCheckedModeBanner: false,
        home: new ListViewBuilder());
  }
}

class ListViewBuilder extends StatefulWidget {
  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  final Color boxOutColor = const Color(0xffFF4D6D);
  final Color backgroundColor = const Color(0xffFFF0F3);

  String selectedDepartment = "Computing and Information Science";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        title: Text(
          "Course Selection",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.black),
        ),
      ),
      body: Consumer<CoursesProvider>(
        builder: (context, value, child) => ListView(
          children: [
            Container(
              //color: Colors.white,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 4),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDepartment,
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: backgroundColor),
                  isExpanded: true,
                  items:
                      value.courses.keys.toList().map(buildMenuItem).toList(),
                  onChanged: (dept) => setState(() {
                    if (dept != null) {
                      selectedDepartment = dept;
                    }
                  }),
                ),
              ),
            ),
            if (value.courses.isNotEmpty)
              for (var course in value.courses[selectedDepartment])
                _buildCourseElement(course['fullname'], course['coursecode'])
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Widget _buildCourseElement(String title, String courseCode) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: boxOutColor, width: 4),
        borderRadius: BorderRadius.circular((22)),
      ),
      child: ListTile(
        //leading: Icon(Icons),
        title: Text(title,
            style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        trailing: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScheduleScreen(courseCode)));
          },
          style: ElevatedButton.styleFrom(
            primary: boxOutColor,
          ),
          icon: Icon(Icons.add, color: backgroundColor),
          label: Text('Join', style: TextStyle(color: backgroundColor)),
          //color: Colors.amber,
        ),
      ),
    );
  }
}
