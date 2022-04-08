import 'package:flutter/material.dart';

List tmpGrps = [
  "CIS 4030",
  "POLS 1000",
  "MCS 1000",
  "CIS 3100",
  "ACCT 1220",
  "MCS 1000"
];

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 240, 243, 1),
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(255, 77, 109, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Group(),
    );
  }
}

class Group extends StatefulWidget {
  @override
  GroupState createState() {
    return GroupState();
  }
}

class GroupState extends State<Group> {
  final Color buttonColor = const Color(0xffFF4D6D);
  final Color textColor = const Color(0xffFFF0F3);

  List tmpGrps = [
    "CIS 4030",
    "POLS 1000",
    "MCS 1000",
    "CIS 3100",
    "ACCT 1220",
    "MCS 1000",
    "CIS 1300",
    "MATH 1000",
    "PHYS 1000",
    "HROB 2090",
    "POLS 1000",
    "CIS 1500",
    "CIS 2500",
  ];

  int itemCount = 0;

  final TextEditingController filterInput = TextEditingController(text: "");
  String filter = "";

  @override
  void initState() {
    super.initState();
    filterInput.addListener(() {
      print(filterInput.text);
      filter = filterInput.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    filterInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  "Hi User101",
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: filterInput,
                  decoration: InputDecoration(
                    focusColor: buttonColor,
                    prefixIcon: Icon(Icons.group),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: "Search Groups",
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: tmpGrps.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return getCourseBox(index, filter, tmpGrps[index]);
              }),
        )
      ],
    );
  }

  Widget getCourseBox(
    int index,
    String input,
    String groupItem,
  ) {
    if (input.length < 3) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              tmpGrps[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 10,
                ),
                onPressed: () {
                  print("Join pressed.");
                },
                child: Text("Join")),
          )
        ]),
      );
    } else if (groupItem.contains(input) ||
        groupItem.contains(input.toUpperCase())) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              tmpGrps[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 10,
                ),
                onPressed: () {
                  print("Join pressed.");
                },
                child: Text("Join")),
          )
        ]),
      );
    }

    return SizedBox.shrink();
  }
}
