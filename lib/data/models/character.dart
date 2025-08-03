class Character {
  late int id;
  late String name;
  late String status;
  late String species;
  String? type;
  late String gender;
  Location? origin;
  late Location location;
  late String image;
  late List<String> episode;
  late String url;
  late DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    this.type,
    required this.gender,
    this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = json['origin'] != null ? Location.fromJson(json['origin']) : null;
    location = Location.fromJson(json['location']);
    image = json['image'];
    episode = List<String>.from(json['episode']);
    url = json['url'];
    created = DateTime.parse(json['created']);
  }
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json['name'], url: json['url']);
  }
}
