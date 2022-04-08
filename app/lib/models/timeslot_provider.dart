import 'dart:convert';

import 'package:app/data/sampletimes.dart';
import 'package:app/models/meeting_time.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'user_data_provider.dart';
import 'package:app/Screens/meeting.dart';

class TimeslotProvider extends ChangeNotifier {
  MeetingTime _nextMeeting = MeetingTime(0, 0, "");
  List<MeetingTime> _userTimeslots = [];
  late WebSocketChannel _webSocketChannel;
  String _semesterName = "Winter 2022";
  bool _currentlyInMeeting = true, _dataFetched = false;

  bool get currentlyInMeeting => _currentlyInMeeting;
  MeetingTime get nextMeeting => _nextMeeting;
  List<MeetingTime> get userTimeslots => _userTimeslots;
  String get semesterName => _semesterName;

  late UserDataProvider? _userDataProvider;
  late BuildContext _context;

  TimeslotProvider(BuildContext context, UserDataProvider? userDataProvider) {
    _context = context;
    _userDataProvider = userDataProvider;
    if (_userDataProvider != null) {
      const port = String.fromEnvironment("PORT", defaultValue: "3000");
      _webSocketChannel = WebSocketChannel.connect(Uri.parse(
          'ws://3.97.30.243:$port/socket/study_sessions?userID=${_userDataProvider?.userID}'));
      _webSocketChannel.stream.listen((event) {
        debugPrint(event);
        final Map<String, dynamic> eventInfo =
            jsonDecode(event.toString()) as Map<String, dynamic>;
        if (eventInfo['message'] == 'timeslot') {
          // NOTE: For Demo Purposes - This will directly modify the currentlyInMeeting value
          // refreshTimeslots().then((value) => notifyListeners());
          _currentlyInMeeting = !_currentlyInMeeting;
          if (_dataFetched) {
            if (_currentlyInMeeting) {
              Navigator.of(_context).push(
                  MaterialPageRoute(builder: (context) => MeetingScreen()));
            } else {
              Navigator.of(_context).pop();
            }
          } else {
            _dataFetched = true;
          }

          notifyListeners();
        }
      });

      // Set the semester name based on the current month
      int month = DateTime.now().month;
      if (month >= 1 && month <= 4) {
        _semesterName = "Winter ${DateTime.now().year}";
      } else if (month >= 5 && month <= 8) {
        _semesterName = "Summer ${DateTime.now().year}";
      } else if (month >= 9 && month <= 12) {
        _semesterName = "Fall ${DateTime.now().year}";
      }

      // Get the current user's timeslots from the API
      refreshTimeslots().then((value) => notifyListeners());
    }
  }

  Future<void> refreshTimeslots() async {
    const port = String.fromEnvironment("PORT", defaultValue: "3000");
    // final timeslots = jsonDecode(();
    var response = await http.get(Uri.parse(
        'http://3.97.30.243:$port/user/${_userDataProvider?.userID}/scheduled-timeslots'));
    var timeslotData = jsonDecode(response.body);
    if (timeslotData['message'] != 'OK') {
      debugPrint("error retrieving timeslot data");
    } else {
      _userTimeslots = [];
      for (int i = 0; i < timeslotData['timeslots'].length; i++) {
        String timeSlot = timeslotData['timeslots'][i]['timeslot'];
        // Create the timeslot objects for each meeting time
        _userTimeslots.add(MeetingTime(
            int.parse(timeSlot.substring(0, 2)),
            int.parse(timeSlot.substring(2)),
            timeslotData['timeslots'][i]['courseID']));

        // Determine if the user is currently in a meeting
        // DateTime now = DateTime.now();
        // _currentlyInMeeting = false;
        // userTimeslots.forEach((slot) {
        //   var timeslotTime = timeslotTimes[slot.timeNum];
        //   if (now.weekday == slot.dayNum + 1 &&
        //       now.hour >= timeslotTime['startTime'] &&
        //       now.hour <= timeslotTime['endTime']) {
        //     _currentlyInMeeting = true;
        //   }
        // });
      }
    }
    notifyListeners();
  }

  Future<void> add(String courseID, String timecode) async {
    const port = String.fromEnvironment("PORT", defaultValue: "3000");
    await http.post(
      Uri.parse(
          "http://3.97.30.243:$port/user/${_userDataProvider?.userID}/scheduled-timeslots"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'courseID': courseID, 'timeslot': timecode}),
    );
    refreshTimeslots();
  }

  void pushContext(BuildContext context) {
    _context = context;
  }
}
