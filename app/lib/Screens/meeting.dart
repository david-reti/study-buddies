import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:app/data/samplemeeting.dart';

class MeetingScreen extends StatefulWidget {
  MeetingScreen({Key? key}) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  int minutesLeft = 60;
  double proportionTimeLeft = 1.0;
  DateTime startTime = DateTime.now();
  Map topics = {
    'Topic 1': {'numUpvotes': 2, 'upvoted': false, 'crossedOut': false},
    'Topic 2': {'numUpvotes': 2, 'upvoted': false, 'crossedOut': false}
  };

  final Color buttonColor = const Color(0xffFF4D6D);
  final Color textColor = const Color(0xffFFF0F3);

  List<Widget> studyTopics = [];

  void crossOut(String topicName) {
    setState(() {
      topics[topicName]['crossedOut'] = true;
      regenerateTopics();
    });
  }

  void upVote(String topicName) {
    setState(() {
      if (!topics[topicName]['upvoted']) {
        topics[topicName]['numUpvotes']++;
        topics[topicName]['upvoted'] = true;
      } else {
        topics[topicName]['numUpvotes']--;
        topics[topicName]['upvoted'] = false;
      }
      regenerateTopics();
    });
  }

  void regenerateTopics() {
    setState(() {
      List<Map> topicsToAdd = [];
      topics.keys.forEach((element) {
        topicsToAdd.add({
          'title': element,
          'numUpvotes': topics[element]['numUpvotes'],
          'upvoted': topics[element]['upvoted'],
          'crossedOut': topics[element]['crossedOut']
        });
      });
      topicsToAdd.sort((a, b) {
        if (a['numUpvotes'] > b['numUpvotes'] ||
            (b['crossedOut'] && !a['crossedOut'])) {
          return -1;
        } else if (a['numUpvotes'] < b['numUpvotes'] ||
            (a['crossedOut'] && !b['crossedOut'])) {
          return 1;
        } else {
          return 0;
        }
      });

      studyTopics = [];
      topicsToAdd.forEach((element) {
        studyTopics.add(studyTopic(element['title'], element['numUpvotes'],
            element['upvoted'], element['crossedOut'], crossOut, upVote));
      });
    });
  }

  final TextEditingController topicController = TextEditingController();

  void recalculateTimeLeft() {
    // minutesLeft = 60 - DateTime.now().difference(startTime).inMinutes;
    minutesLeft = 60 - DateTime.now().difference(startTime).inSeconds;
    if (minutesLeft <= 0) {
      minutesLeft = 0;
    }
    proportionTimeLeft = 1.0 - ((60.0 - minutesLeft) / 60.0);
  }

  Timer? timeLeft;

  @override
  Widget build(BuildContext context) {
    if (timeLeft == null) {
      timeLeft = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          recalculateTimeLeft();
        });
      });
      regenerateTopics();
    }
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(children: [
              SizedBox.fromSize(
                size: const Size(double.infinity, 100),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/study.jpg'),
                      colorFilter:
                          ColorFilter.mode(Colors.black38, BlendMode.multiply),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 24.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Text(
                          SampleMeeting['course'],
                          style: TextStyle(fontSize: 24, color: textColor),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox.fromSize(
                              size: const Size(60, 60),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: CircularProgressIndicator(
                                        value: proportionTimeLeft,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        minutesLeft.toString(),
                                        style: TextStyle(color: textColor),
                                      ),
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
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: ListView(children: studyTopics),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox.fromSize(
                size: const Size(double.infinity, 70),
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              hintText: 'Suggest Topic'),
                          controller: topicController,
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(80, 70),
                        child: ElevatedButton(
                          child: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            primary: buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                            elevation: 0,
                          ),
                          onPressed: () {
                            String toAdd = topicController.value.text;
                            if (toAdd != "") {
                              setState(() {
                                topics[topicController.value.text] = {
                                  'numUpvotes': 1,
                                  'crossedOut': false,
                                  'upvoted': true
                                };
                                regenerateTopics();
                                topicController.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timeLeft?.cancel();
    super.dispose();
  }
}

Widget studyTopic(String topicName, int numberOfUpvotes, bool upvoted,
    bool crossedOut, Function crossOut, Function upVote) {
  Container overlayContainer = crossedOut
      ? Container(
          color: Colors.black38,
          child: Divider(
            color: Colors.white,
            height: double.infinity,
          ),
        )
      : Container();

  Color iconColor = upvoted ? Colors.red : Colors.black;

  Widget internalWidget = SizedBox.fromSize(
    size: const Size(double.infinity, 64),
    child: Card(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(topicName),
              Container(
                child: Row(
                  children: [
                    Text(numberOfUpvotes.toString()),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_circle_up_outlined,
                        color: crossedOut == false ? iconColor : Colors.black,
                      ),
                      onPressed: () => upVote(topicName),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        overlayContainer,
      ]),
    ),
  );

  return GestureDetector(
    onHorizontalDragEnd: (details) => crossOut(topicName),
    child: internalWidget,
  );
}
