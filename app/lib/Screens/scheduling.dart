import 'package:flutter/material.dart';
import 'package:app/data/weekdays.dart';
import 'package:app/models/meeting_time.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

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

  void saveTimeslot() {}
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
            timeslotSelected(i, 0),
            i,
            0));
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Afternoon (2:30 - 3:30)",
            timeslotSelected(i, 1),
            i,
            1));
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Evening (5:30 - 6:30)",
            timeslotSelected(i, 2),
            i,
            2));
        toReturn.add(timeSlotTile(
            updateTimeslot,
            "${dayNames[i]} Night (8:30 - 9:30)",
            timeslotSelected(i, 3),
            i,
            3));
      }
    }
    return toReturn;
  }

  void updateTimeslot(int dayNum, int timeNum) {
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
        selectedMeetingTimes.add(MeetingTime(dayNum, timeNum));
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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Select the times when you are available',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
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
              child: ElevatedButton(
                  onPressed: saveTimeslot,
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(primary: buttonColor)),
            ),
          ],
        ),
      ],
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

Widget timeSlotTile(Function(int, int) update, String title, bool selected,
    int dayNum, int timeNum) {
  return Card(
    child: ListTile(
      title: Text(title),
      trailing: Checkbox(
          value: selected,
          onChanged: (val) {
            update(dayNum, timeNum);
          }),
    ),
  );
}
