import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/con_event.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/view/view_detail.dart';
import 'package:karma_app/widget/router.dart';

class HomeView extends StatefulWidget {
  const HomeView({key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Event>>? getSlider; //TODO: Change variable name
  List<Event> listSlider = [];

  @override
  void initState() {
    super.initState();
    getSlider = fetchEvent(listSlider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Dashboard'), automaticallyImplyLeading: false),
      body: Center(
        //FutureBuilder is a widget that builds itself based on the latest snapshot
        // of interaction with a Future.
        child: FutureBuilder<List<Event>>(
          future: getSlider,
          //we pass a BuildContext and an AsyncSnapshot object which is an
          //Immutable representation of the most recent interaction with
          //an asynchronous computation.
          builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //Display data
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                      title: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Image.network(listSlider[index].imageUrl,
                                  height: 200, fit: BoxFit.fill),
                            ),
                            ListTile(
                              leading: Column(
                                children: <Widget>[
                                  //TODO: Get date from DB
                                  Text(
                                    "17",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "SEP",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              title: Text(
                                listSlider[index].name,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                listSlider[index].organization,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 70),
                                Icon(Icons.location_city),
                                SizedBox(width: 10),
                                Text(
                                  listSlider[index].venue,
                                  style: TextStyle(),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 70),
                                Icon(Icons.star),
                                SizedBox(width: 10),
                                Text(
                                  listSlider[index]
                                      .limitRegistration
                                      .toString(),
                                  style: TextStyle(),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      onTap: () async {
                        pushPage(
                            context,
                            DetailView(
                              eventID: listSlider[index].id,
                              status: listSlider[index].status,
                            ));
                      });
                },
              );
            } else {
              //Return a circular progress indicator.
              return new CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
