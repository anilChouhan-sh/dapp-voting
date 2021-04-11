class Users {
  final String voterID;
  final String name, email, privatekey;

  List<dynamic> contacts;
  Users({this.voterID, this.name, this.email, this.privatekey});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        voterID: json['userid'],
        name: json['name'],
        email: json['email'],
        privatekey: json['privatekey']);
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': voterID,
      'name': name,
      'email': email,
      'privatekey': privatekey
    };
  }
}
