import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'dart:async';
import 'dart:convert';

import 'package:karma_app/models/event.dart';
import 'package:karma_app/view/detail.dart';

//New layout 

Widget createViewItem(Event event, BuildContext context) {
  return ListTile(
      title: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15,15,15,0),
                  child: Image.network(event.imageUrl, height: 200, fit: BoxFit.fill),
                ),
                
                ListTile(
                  leading: Column(
                            children: <Widget>[
                              //TODO: Get date from DB
                              Text("17", style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),),
                              Text("SEP", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                            ],
                          ),
                  title: Text(
                    event.name,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    event.organization,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Row(
                  children: <Widget>[
                     SizedBox(width: 70),
                    Icon(Icons.location_city),
                      SizedBox(width: 10),
                    Text("Location of place", style: TextStyle(),)
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 70),
                    Icon(Icons.star),
                    SizedBox(width: 10),
                    Text("6 spots left", style: TextStyle(),)
                  ],
                ),
                SizedBox(height: 10),
              ],
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
  final jsonEndpoint = "http://10.0.2.2/karma/karma_app";

  final response = await get(jsonEndpoint);

  if (response.statusCode == 200) {
    List events = json.decode(response.body);
    return events.map((event) => new Event.fromJson(event)).toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
