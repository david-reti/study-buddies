import 'dart:async';
import 'package:app/Screens/courses.dart';
import 'package:app/Screens/homepage.dart';
import 'package:app/Screens/meeting.dart';
import 'package:app/models/timeslot_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/data/sampletimes.dart';
import 'package:provider/provider.dart';

class TimeSlotScreen extends StatefulWidget {
  const TimeSlotScreen({Key? key}) : super(key: key);

  @override
  State<TimeSlotScreen> createState() => _TimeslotScreenState();
}

class _TimeslotScreenState extends State<TimeSlotScreen> {
  Timer? timeUntilMeeting;
  Color buttonColor = const Color(0xffFF4D6D);

  Widget build(BuildContext context) {
    Provider.of<TimeslotProvider>(context, listen: false).pushContext(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Current & Upcoming Meetings',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return HomePage();
                }), (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: buttonColor,
      ),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 16, 0, 16),
              child: Consumer<TimeslotProvider>(
                builder: (context, value, child) => Text(
                  value.semesterName,
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 32,
                ),
                color: buttonColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Courses()));
                },
              ),
            ),
          ]),
          Expanded(
            child: Consumer<TimeslotProvider>(
              builder: (context, value, child) => ListView(
                children: [
                  for (int i = 0; i < value.userTimeslots.length; i++)
                    timeSlotTile(
                        "${value.userTimeslots[i].title} - ${dayNames[value.userTimeslots[i].dayNum]} ${timeslotNames[value.userTimeslots[i].timeNum]}")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget timeSlotTile(String title) {
  return Card(
    child: ListTile(
      title: Text(title),
    ),
  );
}
