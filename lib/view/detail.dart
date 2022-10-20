import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';

import 'package:karma_app/models/event.dart';
import 'package:karma_app/view/home.dart';

class SecondScreen extends StatefulWidget {
  final Event value;

  SecondScreen({Key? key, required this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Future join() async {
    //IP address
    var url = Uri.http("192.168.101.116",
        '/karma/karma_app/lib/database/event.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      //TODO: Get user id....
      "user_id":"1", 
      "event_id":widget.value.id,
    });

    var data = json.decode(response.body);
    if (data == "Error") {
      //TODO: switch button to show already joined 
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'Already joined event!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Event joined successfully!',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Detail Page')),
      body: new Container(
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                child: new Text(
                  'EVENT DETAILS',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              ),
              Padding(
                //`widget` is the current configuration. A State object's configuration
                //is the corresponding StatefulWidget instance.
                child: Image.network('${widget.value.imageUrl}'),
                padding: EdgeInsets.all(12.0),
              ),
              Padding(
                child: new Text(
                  'NAME : ${widget.value.name}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'DESCRIPTION : ${widget.value.description}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'VENUE : ${widget.value.venue}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'ORGANIZATION : ${widget.value.organization}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'DATE : ${widget.value.startDate} to ${widget.value.endDate}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              Padding(
                child: new Text(
                  'TIME : ${widget.value.time}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(20.0),
              ),
              ElevatedButton(
                onPressed: () {
                  // Respond to button press
                  join();
                },
                child: Text('Join Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
