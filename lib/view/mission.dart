import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import 'dart:async';
import 'dart:convert';

import 'package:karma_app/controller/mission.dart';
import 'package:karma_app/models/mission.dart';

class Mission extends StatelessWidget {
  const Mission({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  late Future<List<Mission>> getSlider;
  List<Mission> listSlider = [];

  @override
  void initState() {
    super.initState();
    //getSlider = getMission(listSlider);


    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Volunteer Missions'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Upcoming",
            ),
            Tab(
              text: "Completed",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
              // child: FutureBuilder<List<Mission>>(
              //   future: getSlider,
              //   builder: (BuildContext context, AsyncSnapshot<List<Mission>> snapshot) {},
              // ),
              // future: getSlider,
              // builder: (BuildContext context, AsyncSnapshot<List<Mission>> snapshot) {
              //   if(snapshot.connectionState == ConnectionState.done) {
              //     return Column(
              //       children: [
              //         Text('New Quiz'),
              //         ListView.builder(
              //           itemBuilder: (BuildContext context, int index) {
              //               return Container(
              //                 child: Text('$listSlider[index].id')
              //               );
              //           },
              //           itemCount: snapshot.data!.length,
              //           ),
              //       ],
              //     );
              //     }else{
              // chid: CircularProgressindicator(strokeWidth: 1.6, color: Colors.red,),
              //   }
              ),
          Center(
            child: Text("It's rainy here"),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:karma_app/models/mission.dart';
// import 'package:karma_app/view/bottom_view.dart';
// import 'package:karma_app/view/detail.dart';
// import 'package:flutter_session/flutter_session.dart';

// import 'package:http/http.dart' show get;

// import 'dart:async';
// import 'dart:convert';

// class CustomListView extends StatelessWidget {
//   final List<Mission> mission;

//   CustomListView(this.mission);

//   Widget build(context) {
//     return ListView.builder(
//       itemCount: mission.length,
//       itemBuilder: (context, int currentIndex) {
//         return createViewMission(mission[currentIndex], context);
//       },
//     );
//   }
// }

// class Mission extends StatelessWidget {
//   const Mission({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mission'),
//         automaticallyImplyLeading: false),
//       body: new Center(
//           //FutureBuilder is a widget that builds itself based on the latest snapshot
//           // of interaction with a Future.
//           child:
//           new FutureBuilder<List<Mission>>(
//             future:  getMissionJSON(),
//             //we pass a BuildContext and an AsyncSnapshot object which is an
//             //Immutable representation of the most recent interaction with
//             //an asynchronous computation.
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<Mission>? mission = snapshot.data;
//                 return new CustomListView(mission!);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//               //return  a circular progress indicator.
//               return new CircularProgressIndicator();
//             },
//           ),
//         ),
//     );
//   }
// }

// Widget createViewMission(Mission event, BuildContext context) {
//   return ListTile(
//       title: Card(
//             clipBehavior: Clip.antiAlias,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [

//                 ListTile(
//                   leading: Column(
//                             children: <Widget>[
//                               //TODO: Get date from DB
//                               Text("17", style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),),
//                               Text("SEP", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
//                             ],
//                           ),
//                   title: Text(
//                     "event.eventName",
//                     style: new TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     "event.organization",
//                     style: TextStyle(color: Colors.black.withOpacity(0.6)),
//                   ),
//                 ),
//                 Row(
//                   children: <Widget>[
//                      SizedBox(width: 70),
//                     Icon(Icons.location_city),
//                       SizedBox(width: 10),
//                     Text("Location of place", style: TextStyle(),)
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     SizedBox(width: 70),
//                     Icon(Icons.star),
//                     SizedBox(width: 10),
//                     Text("6 spots left", style: TextStyle(),)
//                   ],
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//       onTap: () {
//         //We start by creating a Page Route.
//         //A MaterialPageRoute is a modal route that replaces the entire
//         //screen with a platform-adaptive transition.
//         var route = new MaterialPageRoute(
//           builder: (BuildContext context) => new SecondScreen(value: event),
//         );
//         //A Navigator is a widget that manages a set of child widgets with
//         //stack discipline.It allows us navigate pages.
//         Navigator.of(context).push(route);
//       });
// }

// Future<List<Mission>> getMissionJSON() async {
//   final jsonEndpoint = "http://10.0.2.2/karma/karma_app";

//   final response = await get(jsonEndpoint);

//   if (response.statusCode == 200) {
//     List mission = json.decode(response.body);
//     return mission.map((mission) => new Mission.fromJSON(mission)).toList();
//   } else
//     throw Exception('We were not able to successfully download the json data.');
// }
