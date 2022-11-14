import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/con_badge.dart';
import 'package:karma_app/controller/con_profile.dart';
import 'package:karma_app/model/model_profile.dart';
import 'package:karma_app/services/notification_service.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/custom_error.dart';
import 'package:karma_app/view/login.dart';
import 'package:karma_app/view/notification_badge.dart';
import 'package:karma_app/view/view_leaderboard.dart';
import 'package:karma_app/widget/router.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:karma_app/services/notification_service.dart';

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

  Future<List<Profile>>? getProfile;
  List<Profile> listProfile = [];

  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  late final LocalNotificationService service;
  PushNotification? _notificationInfo;

  @override
  void initState() {
    super.initState();

    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getProfile = fetchProfile(listProfile, id);
        service = LocalNotificationService();
        saveBadges(userID: id);
      });
    });
    _totalNotifications = 0;
    registerNotification();
  }

  void registerNotification() async {
    //...

    await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then((newToken) {
      print("FCM TOKEN");
      print(newToken);
    });
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    // final String? token = await FirebaseMessaging.instance.getToken();
    // if (token == null) return;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onBackgroundMessage(_onBackGroundMessage);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: false, sound: true);

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        print(message.notification?.title);
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

  //Pull to refresh: get updated points and badges
  Future refresh() async {
    setState(() => listProfile.clear());
    setState(() {
      saveBadges(userID: id);
      getProfile = fetchProfile(listProfile, id);
    });
  }

  //Logout of app
  logout() {
    return Container(
      height: 200.0,
      width: 200.0,
      child: Column(
        children: [
          const Text("Are you sure you want to logout?"),
          Container(
            height: 120.0,
            width: 120.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logout.png'),
                    fit: BoxFit.scaleDown)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  preferences.remove('login');
                  pushAndRemove(context, Login());
                },
              ),
              ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
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
                  pushAndRemove(context, BottomView());
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                preferences = await SharedPreferences.getInstance();
                showDialog(
                  context: context,
                  builder: (ctxt) {
                    return AlertDialog(
                        title: const Text(
                          "Logout",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Aleo',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        content: logout());
                  },
                );
              },
              child: Icon(Icons.logout_rounded),
              backgroundColor: Colors.teal,
            ),
            body: RefreshIndicator(
                onRefresh: refresh,
                child: Container(
                    child: FutureBuilder(
                        future: getProfile,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Profile>> snapshot) {
                          ErrorWidget.builder =
                              (FlutterErrorDetails errorDetails) {
                            return CustomError(errorDetails: errorDetails);
                          };
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Column(children: [
                                    // Notification test
                                    // NotificationBadge(
                                    //     totalNotifications:
                                    //         _totalNotifications),
                                    // ElevatedButton(
                                    //   onPressed: () {
                                    //     registerNotification();
                                    //     // sendNotification();
                                    //     // await service.showNotification(
                                    //     //     id: 0,
                                    //     //     title: 'test',
                                    //     //     body: 'testbody');
                                    //   },
                                    //   child: Text('Test'),
                                    // ),

                                    //ROW 1
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          child: Row(children: [
                                            Text(
                                              'Welcome back, $name!',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                          ]),
                                        )),

                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 100.0,
                                                        width: 100.0,
                                                        decoration: const BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/arrow.jpg'),
                                                                fit: BoxFit
                                                                    .scaleDown),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                      const Text(
                                                        'Missions Completed',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${listProfile[index].missionTotal}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontFamily: 'Aleo',
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 100.0,
                                                        width: 100.0,
                                                        decoration: const BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/points.jpg'),
                                                                fit: BoxFit
                                                                    .scaleDown),
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                      const Text(
                                                        'Karma Points',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${listProfile[index].points}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontFamily: 'Aleo',
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      'Karma Journey',
                                                      style: TextStyle(
                                                        fontFamily: 'Aleo',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          5, 15, 5, 15),
                                                      child:
                                                          LinearPercentIndicator(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50,
                                                        animation: true,
                                                        lineHeight: 30.0,
                                                        animationDuration: 2000,

                                                        //TODO: Show Reward clickable popup
                                                        // onAnimationEnd: () {
                                                        //   GestureDetector(
                                                        //       onTap: () async {
                                                        //         await showDialog(
                                                        //             context:
                                                        //                 context,
                                                        //             builder: (context) =>
                                                        //                 AlertDialog(
                                                        //                     title:
                                                        //                         Text('Hello')));
                                                        //       },
                                                        //       child: Container(
                                                        //           child: Text(
                                                        //               'Click')));
                                                        // },

                                                        percent:
                                                            (listProfile[index]
                                                                    .points /
                                                                1000),
                                                        barRadius: const Radius
                                                            .circular(16),
                                                        linearGradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                41, 123, 44),
                                                            Color.fromARGB(255,
                                                                116, 204, 157)
                                                          ],
                                                        ),
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Every 1,000 Karma points collected earns you RM 10 at our local business partners.',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Color.fromARGB(
                                                            255, 65, 65, 65),
                                                      ),
                                                    ),
                                                  ]),
                                            )
                                          ]),
                                    ),

                                    //ROW 3
                                    Container(
                                      height: 200.0,
                                      width: 300.0,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/leaderboard.jpg'),
                                              fit: BoxFit.scaleDown)),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        pushPage(context, LeaderboardView());
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 350,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(.8),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.black12
                                                    .withOpacity(.2),
                                                offset: const Offset(2, 2))
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.emoji_events,
                                              color: Colors.teal,
                                              size: 22,
                                            ),
                                            SizedBox(width: 10),
                                            Text('Leaderboard',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),

                                    //ROW 4
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30.0, left: 20.0, bottom: 20.0),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                  const Text(
                                                    'Badges Earned',
                                                    style: TextStyle(
                                                      fontFamily: 'Aleo',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'List of all badges'),
                                                              content: Container(
                                                                  height: 400.0,
                                                                  width: 300.0,
                                                                  child: GridView.builder(
                                                                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 3 / 4, crossAxisSpacing: 10, mainAxisSpacing: 20),
                                                                      scrollDirection: Axis.vertical,
                                                                      shrinkWrap: true,
                                                                      itemCount: listProfile[index].badgeAll.length,
                                                                      itemBuilder: (BuildContext context, int indexBadge) {
                                                                        return SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Image.network(listProfile[index].badgeAll[indexBadge].badge_img),
                                                                            Text(listProfile[index].badgeAll[indexBadge].badge_name,
                                                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: 25),
                                                                              child: Text(listProfile[index].badgeAll[indexBadge].badge_description, textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic)),
                                                                            )
                                                                          ],
                                                                        ));
                                                                      })),
                                                            );
                                                          });
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Text(
                                                        'View all badges',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Color.fromRGBO(
                                                              136,
                                                              136,
                                                              136,
                                                              1.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]))
                                          ]),
                                    ),

                                    //ROW 5
                                    listProfile[index].badge.isNotEmpty
                                        ? GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 200,
                                                    childAspectRatio: 3 / 2,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                listProfile[index].badge.length,
                                            itemBuilder: (BuildContext context,
                                                int indexBadge) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  Image.network(listProfile[
                                                                          index]
                                                                      .badge[
                                                                          indexBadge]
                                                                      .badge_img),
                                                                  Text(listProfile[
                                                                          index]
                                                                      .badge[
                                                                          indexBadge]
                                                                      .badge_description),
                                                                ]),
                                                          ));
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            listProfile[index]
                                                                .badge[
                                                                    indexBadge]
                                                                .badge_img)),
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container(),
                                  ]);
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })))));
  }

  static Future<void> _onBackGroundMessage(RemoteMessage message) async {
    print('received notification ${message.notification}');
  }

  // static Future<bool> sendNotification() async {
  // }
}
