import 'package:flutter/material.dart';
import 'members.dart';

class GroupList extends StatelessWidget {
  @override
  final List<String> entries = <String>['Group A', 'Group B', 'Group C'];

  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupMembers()));
                  },
                  title: Text(entries[index]),
                  trailing: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text('Join Group'),
                  )));
        });
  }
}
