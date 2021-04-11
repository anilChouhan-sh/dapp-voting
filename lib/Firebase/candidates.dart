class Candidates {
  final int id;
  final String name;

  List<dynamic> contacts;
  Candidates({
    this.id,
    this.name,
  });

  factory Candidates.fromJson(Map<String, dynamic> json) {
    return Candidates(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
