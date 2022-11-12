import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/controller/con_leaderboard.dart';
import 'package:karma_app/model/model_leaderboard.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/custom_error.dart';
import 'package:karma_app/widget/router.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  Future<List<Leaderboard>>? getLeaderboard;
  List<Leaderboard> listLeaderboard = [];
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 10));
    _confettiController.play();
    getLeaderboard = fetchLeaderboard(listLeaderboard);
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboard'),
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
          Align( 
            alignment: Alignment.topCenter, 
            child: ConfettiWidget( 
              confettiController: _confettiController, 
              blastDirectionality: BlastDirectionality.explosive, 
              shouldLoop: true, 
              colors: const [ Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple ], 
              createParticlePath: drawStar, 
            ), 
          ), 

          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/leaderboard_2.png'),
                    fit: BoxFit.scaleDown)),
          ),

          Expanded(
              child: FutureBuilder(
                  future: getLeaderboard,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Leaderboard>> snapshot) {
                    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                      return CustomError(errorDetails: errorDetails);
                    };
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.teal[700],
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            title: Text(listLeaderboard[index].name),
                            trailing:
                                Text(listLeaderboard[index].points.toString()),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 2,
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ]));
  }
}
