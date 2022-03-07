import 'dart:async';
import 'package:app/Screens/courses.dart';
import 'package:app/Screens/homepage.dart';
import 'package:app/Screens/meeting.dart';
import 'package:app/models/meeting_time.dart';
import 'package:flutter/material.dart';
import 'package:app/data/sampletimes.dart';

class TimeSlotScreen extends StatefulWidget {
  TimeSlotScreen(this.userTimeslots);

  List<MeetingTime> userTimeslots = [MeetingTime(1, 2, "CIS*4030")];
  String semesterName = "Winter 2022";

  @override
  State<TimeSlotScreen> createState() => _TimeslotScreenState();
}

class _TimeslotScreenState extends State<TimeSlotScreen> {
  Timer? timeUntilMeeting;
  Color buttonColor = const Color(0xffFF4D6D);

  Widget build(BuildContext context) {
    if (timeUntilMeeting == null) {
      timeUntilMeeting = Timer(const Duration(seconds: 15), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MeetingScreen()));
      });
    }

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
              child: Text(
                widget.semesterName,
                style: TextStyle(fontSize: 32),
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
            child: ListView(
              children: [
                for (int i = 0; i < widget.userTimeslots.length; i++)
                  timeSlotTile(
                      "${widget.userTimeslots[i].title} - ${dayNames[widget.userTimeslots[i].dayNum]} ${timeslotNames[widget.userTimeslots[i].timeNum]}")
              ],
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
