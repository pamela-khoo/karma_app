import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:karma_app/models/event.dart';
import 'package:karma_app/screens/home.dart';
import 'package:karma_app/screens/detail.dart';

class CustomListView extends StatelessWidget {
  final List<Event> events;

  CustomListView(this.events);

  Widget build(context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(events[currentIndex], context);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new Scaffold(
        appBar: new AppBar(title: const Text('Karma')),
        body: new Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child: new FutureBuilder<List<Event>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Event>? events = snapshot.data;
                return new CustomListView(events!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //return  a circular progress indicator.
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
//end

