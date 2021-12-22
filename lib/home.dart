// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:feedmeapp/jsonaccess.dart';
import 'package:feedmeapp/newentry.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'entry.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final JsonAccess ja = JsonAccess();
  late Future<List<Entry>> futureEntries;
  final List<int> colorCodes = <int>[500, 400, 300];

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
            return Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                  JumpingDotsProgressIndicator(fontSize: 40)
                ])));
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
              body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.deepPurple[colorCodes[index]]),
                    padding: const EdgeInsets.all(8),
                    height: 65,
                    child: (Text('${getLastThreeEntries(snapshot.data)[index]}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18))),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 5,
                  thickness: 10,
                  color: Colors.transparent,
                ),
              ),
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
            child: const Text("please wait while data is being retrieved"),
          );
        });
  }
}

getLastThreeEntries(snapshot) {
  List newList = snapshot.reversed.toList();
  return newList;
}
