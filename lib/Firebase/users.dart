class Users {
  final String voterID;
  final String name, email;

  List<dynamic> contacts;
  Users({
    this.voterID,
    this.name,
    this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      voterID: json['userid'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': voterID,
      'name': name,
      'email': email,
    };
  }
}
