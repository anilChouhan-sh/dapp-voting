class Users {
  final String voterID;
  final String name, email, privatekey, userid;

  List<dynamic> contacts;
  Users({this.voterID, this.name, this.email, this.privatekey, this.userid});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        userid: json['userid'],
        voterID: json['voterID'],
        name: json['name'],
        email: json['email'],
        privatekey: json['privatekey']);
  }

  Map<String, dynamic> toMap() {
    return {
      'voterID': voterID,
      'userid': userid,
      'name': name,
      'email': email,
      'privatekey': privatekey
    };
  }
}
