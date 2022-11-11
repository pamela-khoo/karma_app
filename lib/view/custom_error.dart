import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/main.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300.0,
                width: 300.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/error.png'),
                        fit: BoxFit.scaleDown)),
              ),
              Text(
                kDebugMode
                    ? errorDetails.summary.toString()
                    : 'Oups! Something went wrong!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: kDebugMode ? Colors.red : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
              const SizedBox(height: 12),
              const Text(
                kDebugMode
                    ? 'https://docs.flutter.dev/testing/errors'
                    : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
