class Event {
  final String id;
  final String name, imageUrl, description;

  Event({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> jsonData) {
    return Event(
      id: jsonData['id'],
      name: jsonData['name'],
      description: jsonData['description'],
      imageUrl: "http://192.168.101.116/PHP/karma_app/images/" +
          jsonData['image_url'], //IP address
    );
  }
}
