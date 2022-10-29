// import 'package:intl/intl.dart';

// class Event {
//   final String id;
//   final String name, imageUrl, description, venue, organization;
//   final DateTime startDate, endDate;
//   final String time;

//   Event({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.venue,
//     required this.organization,
//     required this.startDate,
//     required this.endDate,
//     required this.time
//   });

//   factory Event.fromJson(Map<String, dynamic> jsonData) {
//     return Event(
//       id: jsonData['id'],
//       name: jsonData['name'],
//       description: jsonData['description'],
//       imageUrl: "http://10.0.2.2/karma/karma_app/images/" +
//           jsonData['image_url'], //IP address
//       venue: jsonData['venue'],
//       organization: jsonData['organization'],
//       startDate: jsonData['startDate'],
//       endDate: jsonData['endDate'],
//       time: jsonData['time'],      
//     );
//   }
// }
