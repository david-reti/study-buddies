import 'package:flutter/material.dart';

List tmpTopics = ["Algebra", "Calculus", "Programming"];
List tmpTopicsVotes = [0, 0, 0];

class TopicScreen extends StatelessWidget {
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
      body: Topic(),
    );
  }
}

class Topic extends StatefulWidget {
  @override
  TopicState createState() {
    return TopicState();
  }
}

class TopicState extends State<Topic> {
  final Color buttonColor = const Color(0xffFF4D6D);
  final Color textColor = const Color(0xffFFF0F3);

  int itemCount = 0;

  final TextEditingController topicInput = TextEditingController(text: "");
  String topic = "";

  Future<void> showAddTopicDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isSelected = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Add Topic"),
              content: Expanded(
                child: TextFormField(
                  controller: topicInput,
                  decoration: InputDecoration(
                    focusColor: buttonColor,
                    prefixIcon: Icon(Icons.topic),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: "Enter Topic",
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: (() {
                      tmpTopics.add(topic);
                      tmpTopicsVotes.add(0);

                      print("Create Topic pressed.");
                      setState(() {});
                      Navigator.pop(context);
                    }),
                    child: Text("Create Topic"))
              ],
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();
    topicInput.addListener(() {
      print(topicInput.text);
      topic = topicInput.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    topicInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  "Study Topics",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 10,
                  ),
                  onPressed: () {
                    showAddTopicDialog(context);
                    print("Join pressed.");
                  },
                  child: Text("Create Topic")),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              itemCount: tmpTopics.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return getCourseBox(index, "", tmpTopics[index]);
              }),
        )
      ],
    );
  }

  Widget getCourseBox(
    int index,
    String input,
    String topicItem,
  ) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: RichText(
                        text: TextSpan(
                            text: tmpTopicsVotes[index].toString() + " ",
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: tmpTopics[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                            ]),
                      )),
                  Spacer(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.plus_one,
                          color: buttonColor,
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            tmpTopicsVotes[index] = tmpTopicsVotes[index] + 1;
                          });
                        },
                      ),
                    ),
                  )
                ]),
          ),
        )));

    return SizedBox.shrink();
  }
}
