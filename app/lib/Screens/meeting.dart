import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  int minutesLeft = 36;
  List<Widget> studyTopics = [
    studyTopic('Topic 1', 10),
    studyTopic('Topic 2', 8)
  ];

  final TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    const Text(
                      'Course Name',
                      style: TextStyle(fontSize: 32),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox.fromSize(
                          size: Size(60, 60),
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Stack(
                              children: [
                                const Center(
                                  child: CircularProgressIndicator(
                                    value: 0.6,
                                  ),
                                ),
                                Center(
                                  child: Text(minutesLeft.toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(children: studyTopics),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Suggest Topic'),
                    controller: topicController,
                  ),
                ),
                Column(mainAxisSize: MainAxisSize.max, children: [
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      String toAdd = topicController.value.text;
                      if (toAdd != "") {
                        setState(() {
                          studyTopics
                              .add(studyTopic(topicController.value.text, 1));
                          topicController.clear();
                        });
                      }
                    },
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget studyTopic(String topicName, int numberOfUpvotes) {
  return Card(
    child: ListTile(
        title: Text(topicName),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_circle_up_outlined),
          onPressed: () {},
        )),
  );
}
