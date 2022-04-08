import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class CoursesProvider extends ChangeNotifier {
  Map<String, dynamic> _courses = {};
  Map<String, dynamic> get courses => _courses;

  CoursesProvider() {
    refreshCourses();
  }

  void refreshCourses() async {
    const port = String.fromEnvironment("PORT", defaultValue: "3000");
    var response = await http.get(Uri.parse('http://3.97.30.243:$port/course'));
    var coursesObject = jsonDecode(response.body);
    coursesObject.forEach((course) {
      if (_courses.containsKey(course['department'])) {
        _courses[course['department']].add(course);
      } else {
        _courses[course['department']] = [course];
      }
    });
    debugPrint(courses.toString());
    notifyListeners();
  }
}
