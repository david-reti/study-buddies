import 'package:flutter/material.dart';
import 'package:app/data/weekdays.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _SchedulScreenState();
}

class _SchedulScreenState extends State<ScheduleScreen> {
  // This is the time selected for the meeting, each week. We only care about the day and hour
  // The other parts are left blank

  bool initialized = false;

  // Only the day and time fields are relevant
  List<DateTime> _selectedMeetingTimes = [];

  List<bool> daySelected = [
    false,
    false,
    false,
    false,
    false,
  ];

  void saveTimeslot() {}
  void changeChecked(bool? val) {}
  List<Widget> generateAvailableTimes(bool generateAll) {
    List<Widget> toReturn = [];
    for (int i = 0; i < 5; i++) {
      if (daySelected[i] || generateAll) {
        toReturn.add(timeSlotTile("${dayNames[i]} Morning (10:30 - 11:30)"));
        toReturn.add(timeSlotTile("${dayNames[i]} Afternoon (2:30 - 3:30)"));
        toReturn.add(timeSlotTile("${dayNames[i]} Evening (5:30 - 6:30)"));
        toReturn.add(timeSlotTile("${dayNames[i]} Night (8:30 - 9:30)"));
      }
    }
    return toReturn;
  }

  List<Widget> availableTimes = [];

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      setState(() {
        availableTimes = generateAvailableTimes(true);
      });
      initialized = true;
    }

    return Column(
      children: [
        const Text('Select the days when you are available'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              for (int i = 0; i < 5; i++)
                dayFilterChip(
                  i,
                  daySelected[i],
                  (val) => {
                    setState(() {
                      daySelected[i] = !daySelected[i];
                      availableTimes = generateAvailableTimes(false);
                    }),
                  },
                )
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget dayFilterChip(
    int dayNum, bool selected, void Function(bool?) selectFunction) {
  return (FilterChip(
    selected: selected,
    onSelected: selectFunction,
    label: Text(dayNames[dayNum]),
  ));
}

Widget timeSlotTile(String title) {
  return Card(
    child: ListTile(
      title: Text(title),
      trailing: Checkbox(
        value: false,
        onChanged: (val) {},
      ),
    ),
  );
}
