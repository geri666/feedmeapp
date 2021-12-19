import 'dart:html';

import 'package:feedmeapp/entry.dart';
import 'package:feedmeapp/home.dart';
import 'package:feedmeapp/jsonaccess.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NewEntry extends StatefulWidget {
  final JsonAccess ja;

  const NewEntry({Key? key, required this.ja}) : super(key: key);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final myController = TextEditingController();
  List<String> titles = [
    "wet food",
    "dry food",
    "fresh water",
    "toilet cleaned"
  ];
  List<bool> checkedBoxes = [false, false, false, false];
  late List<String> _activities = [];
  String message = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  get isChecked => null;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("create new entry"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('please select the completed activites:',
                  style: TextStyle(fontSize: 20)),
              CheckboxListTile(
                  title: Text(titles[0]),
                  checkColor: Colors.black,
                  activeColor: Colors.deepPurple,
                  value: checkedBoxes[0],
                  onChanged: (bool? value) {
                    setState(() {
                      checkedBoxes[0] = value!;
                    });
                  }),
              CheckboxListTile(
                  title: Text(titles[1]),
                  checkColor: Colors.black,
                  activeColor: Colors.deepPurple,
                  value: checkedBoxes[1],
                  onChanged: (bool? value) {
                    setState(() {
                      checkedBoxes[1] = value!;
                    });
                  }),
              CheckboxListTile(
                  title: Text(titles[2]),
                  checkColor: Colors.black,
                  activeColor: Colors.deepPurple,
                  value: checkedBoxes[2],
                  onChanged: (bool? value) {
                    setState(() {
                      checkedBoxes[2] = value!;
                    });
                  }),
              CheckboxListTile(
                  title: Text(titles[3]),
                  checkColor: Colors.black,
                  activeColor: Colors.deepPurple,
                  value: checkedBoxes[3],
                  onChanged: (bool? value) {
                    setState(() {
                      checkedBoxes[3] = value!;
                    });
                  }),
              const Divider(
                height: 3,
                thickness: 2,
                color: Colors.deepPurple,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: TextField(
                  controller: myController,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(hintText: 'add optional message'),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    onPressed: () {
                      _activities.clear();
                      for (int i = 0; i < titles.length; i++) {
                        if (checkedBoxes[i] == true) {
                          _activities.add(titles[i]);
                        }
                      }

                      message = myController.text;
                      // button pressed, activities selected
                      // ignore: unused_local_variable, unnecessary_null_comparison
                      if (_activities.isNotEmpty) {
                        Entry newEntry = Entry(_activities, message);
                        widget.ja.addEntry(newEntry);
                        widget.ja.updateEntries();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      } else {
                        print("empty entry");
                      }
                    },
                    child: const Text('submit entry'),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
