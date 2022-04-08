import 'package:app/Screens/timeslots.dart';
import 'package:app/models/timeslot_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/data/sampletimes.dart';
import 'package:app/models/meeting_time.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  String _courseTitle = "";
  ScheduleScreen(this._courseTitle, {Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _SchedulScreenState();
}

class _SchedulScreenState extends State<ScheduleScreen> {
  // This is the time selected for the meeting, each week. We only care about the day and hour
  // The other parts are left blank

  bool initialized = false;

  List<MeetingTime> selectedMeetingTimes = [];
  Color buttonColor = const Color(0xffFF4D6D);

  List<bool> daySelected = [
    false,
    false,
    false,
    false,
    false,
  ];

  void saveTimeslot() {
    // Generate query to API here
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const TimeSlotScreen();
    }), (context) => false);
  }

  List<Widget> availableTimes = [];
  List<Widget> generateAvailableTimes() {
    bool generateAll =
        !daySelected.reduce((value, element) => value || element);

    List<Widget> toReturn = [];
    for (int i = 0; i < 5; i++) {
      if (daySelected[i] || generateAll) {
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Morning (10:30 - 11:30)",
            widget._courseTitle,
            timeslotSelected(i, 0),
            i,
            0));
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Afternoon (2:30 - 3:30)",
            widget._courseTitle,
            timeslotSelected(i, 1),
            i,
            1));
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Evening (5:30 - 6:30)",
            widget._courseTitle,
            timeslotSelected(i, 2),
            i,
            2));
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Night (8:30 - 9:30)",
            widget._courseTitle,
            timeslotSelected(i, 3),
            i,
            3));
      }
    }
    return toReturn;
  }

  void updateTimeslot(int dayNum, int timeNum, String title) {
    setState(() {
      int added = -1;
      for (int i = 0; i < selectedMeetingTimes.length; i++) {
        if (selectedMeetingTimes[i].dayNum == dayNum &&
            selectedMeetingTimes[i].timeNum == timeNum) {
          added = i;
        }
      }

      if (added != -1) {
        selectedMeetingTimes.removeAt(added);
      } else {
        selectedMeetingTimes.add(MeetingTime(dayNum, timeNum, title));
      }
    });
  }

  void regenerate() {
    setState(() {
      availableTimes = generateAvailableTimes();
    });
  }

  void selectDay(int dayNum) {
    daySelected[dayNum] = !daySelected[dayNum];
    regenerate();
  }

  bool timeslotSelected(dayNum, timeNum) {
    bool found = false;
    for (int i = 0; i < selectedMeetingTimes.length; i++) {
      if (selectedMeetingTimes[i].dayNum == dayNum &&
          selectedMeetingTimes[i].timeNum == timeNum) {
        found = true;
      }
    }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    availableTimes = generateAvailableTimes();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Timeslots',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: buttonColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                for (int i = 0; i < 5; i++)
                  DayFilter(i, daySelected[i], selectDay)
              ],
              alignment: WrapAlignment.center,
              spacing: 10.0,
            ),
          ),
          Expanded(
            child: ListView(
              children: availableTimes,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Consumer<TimeslotProvider>(
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: selectedMeetingTimes.isNotEmpty
                        ? () async {
                            await value.add(selectedMeetingTimes[0].title,
                                "0${selectedMeetingTimes[0].dayNum}0${selectedMeetingTimes[0].timeNum}");
                            saveTimeslot();
                          }
                        : null,
                    child: const Padding(
                        padding: EdgeInsets.all(16), child: Text('Save')),
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DayFilter extends StatefulWidget {
  DayFilter(this.dayNum, this.selected, this.onSelected, {Key? key})
      : super(key: key);
  bool selected = false;
  Function onSelected;
  int dayNum = 0;

  @override
  State<DayFilter> createState() => _DayFilterState();
}

class _DayFilterState extends State<DayFilter> {
  @override
  Widget build(BuildContext context) {
    return (FilterChip(
      selected: widget.selected,
      onSelected: (val) {
        widget.selected = !widget.selected;
        widget.onSelected(widget.dayNum);
      },
      label: Text(dayNames[widget.dayNum]),
    ));
  }
}

Widget timeSlotTile(Function(int, int, String) update, String title,
    String courseCode, bool selected, int dayNum, int timeNum) {
  return Card(
    child: ListTile(
      title: Text(title),
      trailing: Checkbox(
          value: selected,
          onChanged: (val) {
            update(dayNum, timeNum, courseCode);
          }),
    ),
  );
}
