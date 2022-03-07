import 'package:flutter/material.dart';
import 'groups.dart';

class GroupMembers extends StatelessWidget {
  const GroupMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFCCD5),
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Group Members'),
          leading: GestureDetector(
              onTap: () {},
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GroupList()));
                },
              )),
        ),
        body: GroupMembersList(),
      ),
    );
  }
}

class GroupMembersList extends StatelessWidget {
  @override
  final List<String> people = <String>['John', 'Mango', 'Foo'];

  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: people.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.centerLeft,
            height: 50,
            color: Colors.white10,
            child: Text('${people[index]}'),
          );
        });
  }
}
