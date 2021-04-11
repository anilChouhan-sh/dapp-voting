class PrivateKeys {
  final String key;
  final bool taken;

  PrivateKeys({this.key, this.taken});

  factory PrivateKeys.fromJson(Map<String, dynamic> json) {
    return PrivateKeys(
      key: json['key'],
      taken: json['taken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': key,
      'taken': taken,
    };
  }
}
