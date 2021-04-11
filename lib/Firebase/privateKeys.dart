class PrivateKeys {
  final String key;
  final bool taken;
  final String assignedto;
  PrivateKeys({this.key, this.taken, this.assignedto});

  factory PrivateKeys.fromJson(Map<String, dynamic> json) {
    return PrivateKeys(
        key: json['key'], taken: json['taken'], assignedto: json['assignedto']);
  }

  Map<String, dynamic> toMap() {
    return {'key': key, 'taken': taken, 'assignedto': assignedto};
  }
}
