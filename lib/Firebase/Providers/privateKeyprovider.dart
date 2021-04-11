import 'package:dapp_voting/Firebase/firestore.dart';
import 'package:dapp_voting/Firebase/privateKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Keyprovider with ChangeNotifier {
  final firestore_ser = Firestore_ser();
  String _key, _condition, _collection;

  bool _value, _taken;
  String _id;

  var uuid = Uuid();

  //getters

  String get descrition => _key;
  bool get value => _value;
  String get condition => _condition;
  String get collection => _collection;
  bool get taken => _taken;
  String get id => _id;

  Stream<List<PrivateKeys>> get entries =>
      firestore_ser.getKeys(collection, condition, value);

  //Setters

  set changecollection(String collection) {
    _collection = collection;
  }

  set changecondition(String condition) {
    _condition = condition;
  }

  set changekey(String key) {
    _key = key;
    notifyListeners();
  }

  set changeid(String id) {
    _id = id;
    notifyListeners();
  }

  set changedone(bool done) {
    _taken = done;
    notifyListeners();
  }

  //Functions
  loadAll(PrivateKeys pk) {
    if (pk != null) {
      _taken = pk.taken;
      _key = pk.key;
    } else {
      _taken = null;
      _key = null;
    }
  }

  String saveEntry() {
    String id = uuid.v1();
    if (_id == null) {
      //Add
      var newEntry = PrivateKeys(
        key: _key,
        taken: _taken,
      );
      print(newEntry.key);
      firestore_ser.setEntry(newEntry, 'privatekeys');
      return id;
    } else {
      //Edit
      var updatedEntry = PrivateKeys(
        key: _key,
        taken: _taken,
      );
      firestore_ser.setEntry(updatedEntry, 'privatekeys');
    }
    return "";
  }

  removeEntry(String entryId, String collection) {
    firestore_ser.removeEntry(entryId, collection);
  }
}
