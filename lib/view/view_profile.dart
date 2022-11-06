import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/con_badge.dart';
import 'package:karma_app/model/model_badge.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/login.dart';
import 'package:karma_app/view/notification_badge.dart';
import 'package:karma_app/widget/router.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}

class ProfileView extends StatefulWidget {
  const ProfileView({key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late SharedPreferences preferences;
  String id = '', name = '', email = '';

  late Future<List<Badge>>? getBadge;
  List<Badge> listBadge = [];

  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  @override
  void initState() {
    super.initState();
    getBadge = fetchBadge(listBadge);
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
      });
    });
    _totalNotifications = 0;
  }

  void registerNotification() async {
    //...

    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
  _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;

          if (_notificationInfo != null) {
            // For displaying the notification as an overlay
            showSimpleNotification(
              Text(_notificationInfo!.title!),
              leading:
                  NotificationBadge(totalNotifications: _totalNotifications),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 2),
            );
          } else {
            showSimpleNotification(
              Text('notification is null'),
              leading:
                  NotificationBadge(totalNotifications: _totalNotifications),
              subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 2),
            );
          }
        });
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: Scaffold(
            appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.handshake_outlined, color: Colors.white),
          onPressed: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    BottomView()), (Route<dynamic> route) => false);
          },
        ),
      ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                preferences = await SharedPreferences.getInstance();
                preferences.remove('login');
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
Login()), (Route<dynamic> route) => false);
              },
              child: Icon(Icons.logout_rounded),
              backgroundColor: Colors.teal,
            ),
            body: Column(children: <Widget>[
              Expanded(
                  child: ListView(children: <Widget>[
                NotificationBadge(totalNotifications: _totalNotifications),
                ElevatedButton(
                  onPressed: () {
                    registerNotification();
                  },
                  child: Text('Test'),
                ),
                //ROW 1
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/arrow.jpg'),
                                            fit: BoxFit.scaleDown),
                                        shape: BoxShape.circle),
                                  ),
                                  const Text(
                                    'Missions Completed',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '5', //TODO: get value from db count missions where user_id = {id} and status = 1
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Aleo',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/points.jpg'),
                                            fit: BoxFit.scaleDown),
                                        shape: BoxShape.circle),
                                  ),
                                  const Text(
                                    'Karma Points',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '50', //TODO: get value from db get points from user where user_id = {id}
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Aleo',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),

                //ROW 2
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Karma Journey',
                                  style: TextStyle(
                                    fontFamily: 'Aleo',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 30.0,
                                    animationDuration: 2000,
                                    percent:
                                        0.6, //TODO: Change to value from DB
                                    barRadius: const Radius.circular(16),
                                    linearGradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 41, 123, 44),
                                        Color.fromARGB(255, 116, 204, 157)
                                      ],
                                    ),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                                const Text(
                                  'Every 1,000 Karma points collected earns you RM 10 at our local business partners.',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ]),
                        )
                      ]),
                ),

                //ROW 3
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              const Text(
                                'Badges Earned',
                                style: TextStyle(
                                  fontFamily: 'Aleo',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ]))
                      ]),
                ),

                //ROW 4
                //Badges in GridView
                //TODO: display from profile API

                Container(
                    child: FutureBuilder(
                  future: getBadge,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Badge>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(children: [
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        listBadge[index].badge_img),
                                  ),
                                ),
                                child: Center(
                                  // child: listBadge[index].badge_status == 1
                                  //     ? Text('Achieved')
                                  //     : Text('No'),
                                ),
                              );
                            })
                      ]);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
              ])),
            ])));
  }
}

//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Profile"),
//           automaticallyImplyLeading: false,
//           elevation: 0,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             preferences = await SharedPreferences.getInstance();
//             preferences.remove('login');
//             pushAndRemove(context, Login());
//           },
//           child: Icon(Icons.logout_rounded),
//           backgroundColor: Colors.green,
//         ),
//         body: Column(children: <Widget>[
//           Expanded(
//               child: ListView(children: <Widget>[
//             NotificationBadge(totalNotifications: _totalNotifications),
//             ElevatedButton(
//               onPressed: () {
//                 registerNotification();
//               },
//               child: Text('Test'),
//             ),
//             //ROW 1
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 height: 100.0,
//                                 width: 100.0,
//                                 decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage('assets/arrow.jpg'),
//                                         fit: BoxFit.scaleDown),
//                                     shape: BoxShape.circle),
//                               ),
//                               const Text(
//                                 'Missions Completed',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Text(
//                                 '5', //TODO: get value from db count missions where user_id = {id} and status = 1
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontFamily: 'Aleo',
//                                   fontStyle: FontStyle.normal,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Flexible(
//                       fit: FlexFit.tight,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 height: 100.0,
//                                 width: 100.0,
//                                 decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage('assets/points.jpg'),
//                                         fit: BoxFit.scaleDown),
//                                     shape: BoxShape.circle),
//                               ),
//                               const Text(
//                                 'Karma Points',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Text(
//                                 '50', //TODO: get value from db get points from user where user_id = {id}
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontFamily: 'Aleo',
//                                   fontStyle: FontStyle.normal,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 25,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),

//             //ROW 2
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child:
//                   Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Expanded(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'Karma Journey',
//                           style: TextStyle(
//                             fontFamily: 'Aleo',
//                             fontStyle: FontStyle.normal,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
//                           child: LinearPercentIndicator(
//                             width: MediaQuery.of(context).size.width - 50,
//                             animation: true,
//                             lineHeight: 30.0,
//                             animationDuration: 2000,
//                             percent: 0.6, //TODO: Change to value from DB
//                             barRadius: const Radius.circular(16),
//                             linearGradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 41, 123, 44),
//                                 Color.fromARGB(255, 116, 204, 157)
//                               ],
//                             ),
//                             backgroundColor: Colors.grey[300],
//                           ),
//                         ),
//                         const Text(
//                           'Every 1,000 Karma points collected earns you RM 10 at our local business partners.',
//                           style: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                       ]),
//                 )
//               ]),
//             ),

//             //ROW 3
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child:
//                   Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Expanded(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                       const Text(
//                         'Badges Earned',
//                         style: TextStyle(
//                           fontFamily: 'Aleo',
//                           fontStyle: FontStyle.normal,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25,
//                         ),
//                       ),
//                     ]))
//               ]),
//             ),

//             //ROW 4
//             //Badges in GridView

//             Container(
//                 child: FutureBuilder(
//               future: getBadge,
//               builder:
//                   (BuildContext context, AsyncSnapshot<List<Badge>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Stack(children: [
//                     GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithMaxCrossAxisExtent(
//                                 maxCrossAxisExtent: 200,
//                                 childAspectRatio: 3 / 2,
//                                 crossAxisSpacing: 20,
//                                 mainAxisSpacing: 20),
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             width: double.infinity,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(listBadge[index].badge_img),
//                               ),
//                             ),
//                             child: Center(
//                               child: listBadge[index].badge_status == 1
//                                   ? Text('Achieved')
//                                   : Text('No'),
//                             ),
//                           );
//                         })
//                   ]);
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             )),
//           ])),
//         ]));
//   }
// }
