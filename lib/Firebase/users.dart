class Users {
  final String voterID;
  final String name, email, privatekey, userid;
  final bool rights;
  List<dynamic> contacts;
  Users(
      {this.voterID,
      this.name,
      this.email,
      this.privatekey,
      this.userid,
      this.rights});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        userid: json['userid'],
        voterID: json['voterID'],
        name: json['name'],
        email: json['email'],
        privatekey: json['privatekey'],
        rights: json['rights']);
  }

  Map<String, dynamic> toMap() {
    return {
      'voterID': voterID,
      'userid': userid,
      'name': name,
      'email': email,
      'privatekey': privatekey,
      'rights': rights
    };
  }
}
