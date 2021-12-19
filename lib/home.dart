import 'dart:math';

import 'package:feedmeapp/jsonaccess.dart';
import 'package:feedmeapp/newentry.dart';
import 'package:flutter/material.dart';

import 'entry.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final JsonAccess ja = JsonAccess();
  late Future<List<Entry>> futureEntries;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => refresh());
    futureEntries = ja.readEntries();
  }

  void refresh() {
    setState(() {
      futureEntries = ja.readEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureEntries,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  title: const Text("FeedMe! home"),
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      tooltip: 'refresh',
                      onPressed: () {
                        refresh();
                      },
                    ),
                  ]),
              body: Center(child: Text(snapshot.data.toString())),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewEntry(ja: ja)),
                    );
                  }),
            );
          }
          return Container(
            child: Text("please wait while data is being retrieved"),
          );
        });
  }
}
