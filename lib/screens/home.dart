import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'dart:async';
import 'dart:convert';

import 'package:karma_app/models/event.dart';
import 'package:karma_app/screens/detail.dart';

Widget createViewItem(Event event, BuildContext context) {
  return new ListTile(
      title: new Card(
        elevation: 5.0,
        child: new Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                child: Image.network(event.imageUrl),
                padding: EdgeInsets.only(bottom: 8.0),
              ),
                Padding(
                    child: Text(
                      event.name,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.all(1.0)),
                Padding(
                    child: Text(
                      event.description,
                      style: new TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.all(1.0)),
            ],
          ),
        ),
      ),
      onTap: () {
        //We start by creating a Page Route.
        //A MaterialPageRoute is a modal route that replaces the entire
        //screen with a platform-adaptive transition.
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new SecondScreen(value: event),
        );
        //A Navigator is a widget that manages a set of child widgets with
        //stack discipline.It allows us navigate pages.
        Navigator.of(context).push(route);
      });
}

//Future is n object representing a delayed computation.
Future<List<Event>> downloadJSON() async {
  final jsonEndpoint = "http://192.168.101.116/PHP/karma_app";

  final response = await get(jsonEndpoint);

  if (response.statusCode == 200) {
    List events = json.decode(response.body);
    return events.map((event) => new Event.fromJson(event)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
