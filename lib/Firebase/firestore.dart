import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapp_voting/Firebase/candidates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dapp_voting/Firebase/users.dart';
import 'privateKeys.dart';

// ignore: camel_case_types
class Firestore_ser {
  /* String _condition;
  String _value;

  String get condition => _condition;
  String get value => _value;*/

  // var uuid = Uuid();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //get Entries

  Stream<List<PrivateKeys>> getKeys(
      String collection, String condition, bool value) {
    return _db
        .collection("privateKeys")
        .where(condition, isEqualTo: value)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrivateKeys.fromJson(doc.data()))
            .toList());
  }

  Stream<List<Users>> getUsers() {
    return _db.collection('user').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }

  Stream<List<Candidates>> getCandidates() {
    return _db.collection('candidates').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Candidates.fromJson(doc.data())).toList());
  }

//Upsert
  Future<void> setEntry(dynamic entry, String collection) {
    var options = SetOptions(merge: true);
    if (collection == 'privatekeys')
      return _db.collection(collection).doc().set(entry.toMap(), options);
    else if (collection == 'users')
      return _db.collection(collection).doc().set(entry.toMap(), options);
    else
      return _db
          .collection(collection)
          .doc(entry.voterID)
          .set(entry.toMap(), options);
  }

  //Delete
  Future<void> removeEntry(String entryId, String collection) {
    return _db.collection(collection).doc(entryId).delete();
  }
}
