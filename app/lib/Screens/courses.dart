import 'package:app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:app/Screens/register.dart';
import 'package:flutter/cupertino.dart';

class Courses extends StatefulWidget {
  @override
  State<Courses> createState() => _CoursesState();
  // TODO: implement createState
  //throw UnimplementedError();

}

class _CoursesState extends State<Courses> {
  final items = [
    'Accounting',
    'Agriculture',
    'Animal Science',
    'Anthropology',
    'Arabic',
    'Computing',
  ];
  final Color themeColor = const Color(0xffFF4D6D);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        title: "ListView.builder",
        theme: new ThemeData(
            //primarySwatch: Colors.red
            primarySwatch: Colors.red),
        debugShowCheckedModeBanner: false,
        home: new ListViewBuilder());
  }
}

class ListViewBuilder extends StatefulWidget {
  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  final Color boxOutColor = const Color(0xffFF4D6D);
  final items = [
    'Accounting',
    'Agriculture',
    'Animal Science',
    'Anthropology',
    'Arabic',
    'Computing',
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {})
        ],*/
        title: Text(
          "Courses",
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
              //color: Colors.white,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 4),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  isExpanded: true,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              //color: Colors.white,
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-1000',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons.date_range),
                title: Text('CIS-1200',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              //color: Colors.white,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-1250',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons.date_range),
                title: Text('CIS-1500',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-1910',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2030',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2050',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2130',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2170',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2250',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2430',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2460',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2500',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
          Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: boxOutColor, width: 1),
                borderRadius: BorderRadius.circular((22)),
              ),
              child: ListTile(
                //leading: Icon(Icons),
                title: Text('CIS-2520',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('Join'),
                  //color: Colors.amber,
                ),
              )),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}
