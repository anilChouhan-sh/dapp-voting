class Candidates {
  final int id, votes;
  final String name;

  List<dynamic> contacts;
  Candidates({
    this.id,
    this.name,
    this.votes,
  });

  factory Candidates.fromJson(Map<String, dynamic> json) {
    return Candidates(id: json['id'], name: json['name'], votes: json['votes']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'votes': votes};
  }
}
