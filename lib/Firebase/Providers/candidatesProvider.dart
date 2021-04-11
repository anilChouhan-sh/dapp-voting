import 'package:dapp_voting/Firebase/candidates.dart';
import 'package:flutter/cupertino.dart';

import '../firestore.dart';
import '../candidates.dart';

class CandidatesProvider with ChangeNotifier {
  final firestore = Firestore_ser();

  Candidates _currentCandidate;

  String _name;
  int _id;
//getter
  String get name => _name;
  int get id => _id;

  Stream<List<Candidates>> get candidates => firestore.getCandidates();
  Candidates get currentUser => _currentCandidate;
//setter

  set changeCurrentCandidates(Candidates name) {
    _currentCandidate = name;
    notifyListeners();
  }

  set changevoterID(int id) {
    _id = id;
    notifyListeners();
  }

  loadAll(Candidates candidates) {
    if (candidates != null) {
      _name = candidates.name;
      _id = candidates.id;
    } else {
      _id = null;

      _name = null;
    }
  }

  savecandidates() {
    //Edit
    var updatedUser = Candidates(name: _name, id: _id);
    firestore.setEntry(updatedUser, 'user');
  }
}
