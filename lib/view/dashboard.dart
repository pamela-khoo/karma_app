import 'package:flutter/material.dart';
import 'package:karma_app/models/event.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/home.dart';
import 'package:karma_app/view/detail.dart';
import 'package:flutter_session/flutter_session.dart';

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

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false),
      body: new Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child: 
          new FutureBuilder<List<Event>>(
            future:  downloadJSON(),
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
    );
  }
}