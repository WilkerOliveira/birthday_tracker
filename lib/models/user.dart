class User {
  String id;
  String email;
  bool isAnonymous;

  User.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        isAnonymous = map['isAnonymous'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['email'] = email;
    map['isAnonymous'] = isAnonymous;

    return map;
  }
}
