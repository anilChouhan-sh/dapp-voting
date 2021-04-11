import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseAuth {
  Future<bool> currentUser(BuildContext context);
  Future<String> signIn(String email, String password);
  Future<User> createUser(
      String email, String password, String phone, String name);
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  myToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool flag = false;
  Future<String> signIn(String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(user.user.email);
      flag = true;
      return user.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        myToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        myToast('Wrong password provided for that user.');
      }
      return e.code;
    }
  }

  Future<User> createUser(
      String email, String password, String voterID, String name) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User x = _firebaseAuth.currentUser;
      print(x.metadata);
      try {
        await user.user.sendEmailVerification();
      } catch (e) {
        print("dfsfwerfgrewgfrgrgewrgrwegwr");
        print(e.message);
      }
      CollectionReference ref = FirebaseFirestore.instance.collection('user');
      ref.doc(user.user.uid).set({
        "name": name,
        "email": user.user.email,
        "voterID": voterID,
        "userid": user.user.uid,
      });
      myToast('User Created.Check Your inbox for email verification');
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        myToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        myToast('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool> currentUser(BuildContext context) async {
    _firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        if (user.emailVerified) {
          print(user.providerData);
          print('User is signed in!');
          return true;
        } else if (flag) {
          myToast('Email Not verfied');
          return false;
        }
      }
    });
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
