import 'package:flutter/cupertino.dart';

import '../firestore.dart';
import '../users.dart';

class UserProvider with ChangeNotifier {
  final firestore = Firestore_ser();

  Users _currentUser;

  String _name;
  String _voterID;
  String _email;
  String _userid;
  String _key;
//getter

  String get name => _name;
  String get voterID => _voterID;
  String get email => _email;
  String get userid => _userid;
  Stream<List<Users>> get users => firestore.getUsers();
  Users get currentUser => _currentUser;
  String get key => currentUser.privatekey;
//setter

  set changeCurrentUser(Users name) {
    _currentUser = name;
    // notifyListeners();
  }

  set changekey(String key) {
    _key = key;
    notifyListeners();
  }

  set changename(String value) {
    _name = value;
    notifyListeners();
  }

  set changevoterID(String voterID) {
    _voterID = voterID;
    notifyListeners();
  }

  set changeuserid(String userid) {
    _userid = userid;
    notifyListeners();
  }

  set changeemail(String value) {
    _email = value;
    notifyListeners();
  }

  loadAll(Users user) {
    if (user != null) {
      _name = user.name;
      _email = user.email;
      _voterID = user.voterID;
    } else {
      _email = null;

      _name = null;
      _voterID = null;
    }
  }

  saveUser() {
    //Edit
    var updatedUser = Users(email: _email, name: _name, voterID: _voterID);
    firestore.setEntry(updatedUser, 'user');
  }
}
